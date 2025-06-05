part of 'get_recomendation_product_bloc.dart';

sealed class GetRecomendationProductState extends Equatable {
  const GetRecomendationProductState();
  
  @override
  List<Object> get props => [];
}

final class GetRecomendationProductInitial extends GetRecomendationProductState {}
final class GetRecomendationProductLoading extends GetRecomendationProductState {}
final class GetRecomendationProductSuccess extends GetRecomendationProductState {
  GetRecomendationProductResponseModel dataRecomendation;
  GetRecomendationProductSuccess({required this.dataRecomendation});
}
final class GetRecomendationProductFailed extends GetRecomendationProductState {
  String message;
  GetRecomendationProductFailed({required this.message});
}
