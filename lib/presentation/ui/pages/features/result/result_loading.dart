import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/theme/color.dart';

import '../../../../../config/routes/Route.dart';
import '../../../../../domain/utils/logger.dart';
import '../questions/model/result_question_list.dart';
import 'bloc/result_scan/result_scan_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ResultLoading extends StatelessWidget {
  final List<ResultQuestionList> question;
  const ResultLoading({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultScanBloc(),
      child: ResultLoadingView(question: question),
    );
  }
}

class ResultLoadingView extends StatefulWidget {
  final List<ResultQuestionList> question;
  const ResultLoadingView({super.key, required this.question});

  @override
  State<ResultLoadingView> createState() => ResultLoadingViewState();
}

class ResultLoadingViewState extends State<ResultLoadingView> {
  @override
  void initState() {
    super.initState();
    context.read<ResultScanBloc>().add(
      GetResultScanEvent(question: widget.question),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResultScanBloc, ResultScanState>(
      listener: (context, state) {
        // if (state is ResultScanSuccess) {
        //   logger.d('go to scan result');
        //   Navigator.pushNamedAndRemoveUntil(
        //     context,
        //     routeResultScan,
        //     ModalRoute.withName(routeHome),
        //     arguments: state.scanSuccesfullResponseModel,
        //   );
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PopScope(
          canPop: false,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Menganalisis hasil wajah Anda...",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: blueTextColor,
                    ),
                  ),
                  // SizedBox(height: 20),
                  Container(
                    width: 120,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,

                      /// Required, The loading type of the widget
                      colors: const [
                        Color(0xFF1977FF), // Biru terang tapi lembut
                        Color(0xFFFF5ACD), // Pink lembut, tidak terlalu neon
                        Color(0xFFFFD93D), // Kuning pastel, nyaman di mata
                      ],

                      /// Optional, The color collections
                      strokeWidth: 2,

                      /// Optional, The stroke of the line, only applicable to widget which contains line
                      backgroundColor: Colors.transparent,

                      /// Optional, Background of the widget
                      pathBackgroundColor: Colors.black,

                      /// Optional, the stroke backgroundColor
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
