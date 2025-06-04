import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/model/result_question_list.dart';

import '../../../../../../../dependency_injector.dart';
import '../../../../../../../domain/services/sharedPreferences-services.dart';
import '../../model/scan_successfull_response_model.dart';
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

      // Emit state sukses
      emit(ResultScanSuccess(scanSuccesfullResponseModel: resultScan));
    } catch (e) {
      // Emit error state jika terjadi exception
      logger.e("Error scan result $e");
      emit(
        ResultScanFailure(errorMessage: e.toString()),
      ); // Ganti RoutineError ke ResultScanError
    }
  }
}
