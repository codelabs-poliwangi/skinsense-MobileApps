import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/model/result_question_list.dart';
import 'package:skinisense/presentation/ui/pages/features/result/package/package_from_loading_to_scan_result.dart';

import '../../../../../../../dependency_injector.dart';
import '../../../../../../../domain/services/sharedPreferences-services.dart';
import '../../repositories/result_repositories.dart';

part 'result_scan_event.dart';
part 'result_scan_state.dart';

class ResultScanBloc extends Bloc<ResultScanEvent, ResultScanState> {
  ResultScanBloc() : super(ResultScanInitial()) {
    on<ResultScanEvent>((event, emit) {});
    on<GetResultScanEvent>(getResultScan);
  }
  Future<void> getResultScan(
    GetResultScanEvent event,
    Emitter<ResultScanState> emit,
  ) async {
    // emit(ResultScanInitial());

    try {
      emit(ResultScanLoading());

      // Ambil instance repository via dependency injection
      final resultRepository = di<ResultRepositories>();
      List<ResultQuestionList> question = event.question;
      String? imageRightSide = await SharedPreferencesService().getString(
        'scan_face_right',
      );
      String? imageLeftSide = await SharedPreferencesService().getString(
        'scan_face_left',
      );
      String? imageFrontSide = await SharedPreferencesService().getString(
        'scan_face_front',
      );
      // Panggil fungsi postScan dari repository
      final resultScan = await resultRepository.postScan(
        answer: question,
        imageDepan: File(imageFrontSide!),
        imageKiri: File(imageLeftSide!),
        imageKanan: File(imageRightSide!),
      );
      logger.d("Success scan result $resultScan");
      final acneScore = (double.tryParse(resultScan.acneScore) ?? 0) * 100;
      final wrinkleScore =
          (double.tryParse(resultScan.wrinkleScore) ?? 0) * 100;
      final flexScore = (double.tryParse(resultScan.flexScore) ?? 0) * 100;

      print("Acne: ${acneScore.toStringAsFixed(0)}%");
      print("Wrinkle: ${wrinkleScore.toStringAsFixed(0)}%");
      print("Flek: ${flexScore.toStringAsFixed(0)}%");

      // Step 1: Masukkan ke dalam list
      final conditions = [
        {'label': 'Acne', 'value': acneScore},
        {'label': 'Wrinkle', 'value': wrinkleScore},
        {'label': 'Flek', 'value': flexScore},
      ];

      // Step 2: Urutkan dari yang terbesar ke terkecil
      conditions.sort((a, b) => (b['value'] as double).compareTo(a['value'] as double));

      // Step 3: Ambil kondisi utama (yang paling tinggi)
      final mainCondition = conditions.first;
      final mainLabel = mainCondition['label'];
      final mainValue = mainCondition['value'];

      print("Kondisi utama: $mainLabel ($mainValue%)");

      // Step 4: Tentukan deskripsi
      String mainDescription = '';
      String recomDecs="";

      switch (mainLabel) {
        case 'Acne':
        recomDecs = "Sesuai dengan hasil analisa kulit kamu yang menunjukkan sedang berjuang melawan jerawat, kami merekomendasikan produk skincare yang tepat untuk meredakan dan mencegah munculnya jerawat baru. Untuk perawatan yang efektif, gunakan produk dengan kandungan seperti Salicylic Acid, Tea Tree Oil, Niacinamide, Centella Asiatica, dan Zinc. Kandungan-kandungan ini dikenal mampu membersihkan pori-pori, menenangkan peradangan, serta mengontrol produksi minyak berlebih di kulit wajah. Pastikan juga kulit kamu tetap terhidrasi agar tidak memperparah kondisi jerawat, ya!";
          mainDescription =
              'Hasil analisa menunjukkan kalau kulit kamu lagi berjuang sama jerawat nih. Yuk, kita fokus dulu untuk menenangkan dan meredakan si jerawat bandel ini. Tapi tenang, perawatan untuk flek dan kerutan juga tetap lanjut kok, biar kulitmu makin bersih, sehat, dan makin pede setiap hari!';
          break;
        case 'Wrinkle':
        recomDecs = "Sesuai dengan hasil analisa kulit kamu yang menunjukkan tanda-tanda munculnya kerutan, kami merekomendasikan produk skincare anti-aging yang tepat untuk membantu menjaga kekencangan dan elastisitas kulit. Untuk perawatan yang efektif, gunakan produk dengan kandungan seperti Retinol, Peptide, Hyaluronic Acid, Vitamin C, dan Ceramide. Kandungan-kandungan ini dikenal mampu merangsang regenerasi sel kulit, meningkatkan produksi kolagen, serta menjaga kelembapan kulit agar tampak lebih halus dan awet muda. Jangan lupa gunakan sunscreen setiap hari agar perlindungan kulitmu semakin optimal!";
          mainDescription =
              'Hasil analisa menunjukkan kalau kulit kamu mulai menunjukkan tanda-tanda kerutan nih. Nggak perlu khawatir, kita bakal fokus buat bantu kulitmu tetap kencang dan terawat. Sambil itu, jerawat dan flek juga tetap kita rawat bareng-bareng ya, biar kulitmu tetap sehat, glowing, dan makin percaya diri!';
          break;
        case 'Flek':
        recomDecs = "Sesuai dengan hasil analisa kulit kamu yang menunjukkan masalah flek cukup menonjol, kami merekomendasikan produk skincare yang tepat untuk membantu mencerahkan dan menyamarkan flek hitam. Untuk hasil yang optimal, kamu bisa menggunakan produk dengan kandungan seperti Niacinamide, Vitamin C, Alpha Arbutin, atau Licorice Extract yang dikenal efektif dalam mengurangi hiperpigmentasi dan membuat kulit tampak lebih cerah merata. Jangan lupa juga untuk selalu memakai sunscreen di pagi hari agar hasilnya maksimal dan kulit tetap terlindungi!";
          mainDescription =
              'Hasil analisa menunjukkan bahwa kulit kamu sedang mengalami masalah flek yang cukup menonjol. Yuk, kita fokus dulu untuk mencerahkan dan menyamarkan flek ini. Tenang aja, sambil itu, perawatan untuk jerawat dan kerutan tetap jalan, biar kulitmu makin sehat, cerah, dan percaya diri!';
          break;
      }

      print("Deskripsi: $mainDescription");

      // double mainConditionValue = (double.tryParse(mainCondition.value) ?? 0) * 100;
      // Emit state sukses
      PackageFromLoadingToScanResult result = PackageFromLoadingToScanResult(
        condition: conditions,
        id: resultScan.id,
        recomDesc: recomDecs,
        description: mainDescription,
      );
      emit(ResultScanSuccess(resultScan: result));
    } catch (e) {
      // Emit error state jika terjadi exception
      logger.e("Error scan result $e");
      emit(
        ResultScanFailure(errorMessage: e.toString()),
      ); // Ganti RoutineError ke ResultScanError
    }
  }
}
