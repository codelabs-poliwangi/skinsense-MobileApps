part of 'result_scan_bloc.dart';

sealed class ResultScanState extends Equatable {
  const ResultScanState();
  
  @override
  List<Object> get props => [];
}

final class ResultScanInitial extends ResultScanState {}
final class ResultScanLoading extends ResultScanState {}
final class ResultScanSuccess extends ResultScanState {
  final PackageFromLoadingToScanResult resultScan;
  const ResultScanSuccess({required this.resultScan});
}
final class ResultScanFailure extends ResultScanState {
  final String errorMessage;
  const ResultScanFailure({required this.errorMessage});
}