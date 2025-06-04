import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes/Route.dart';
import '../../../../../domain/utils/logger.dart';
import '../questions/model/result_question_list.dart';
import 'bloc/result_scan/result_scan_bloc.dart';

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
        if (state is ResultScanSuccess) {
          logger.d('go to scan result');
          Navigator.pushNamedAndRemoveUntil(
            context,
            routeResultScan,
            ModalRoute.withName(routeHome),
            arguments: state.scanSuccesfullResponseModel,
          );
        }
      },
      child: Scaffold(
        body: PopScope(
          canPop: false,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tunggu Sebentar..."),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
