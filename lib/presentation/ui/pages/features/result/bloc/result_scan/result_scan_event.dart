part of 'result_scan_bloc.dart';

sealed class ResultScanEvent extends Equatable {
  const ResultScanEvent();

  @override
  List<Object> get props => [];
}
final class GetResultScanEvent extends ResultScanEvent {
  final List<ResultQuestionList> question;
  const GetResultScanEvent({required this.question});
}