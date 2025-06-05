part of 'get_recomendation_product_bloc.dart';

sealed class GetRecomendationProductEvent extends Equatable {
  const GetRecomendationProductEvent();

  @override
  List<Object> get props => [];
}
final class GetRecomendationProductFromScan extends GetRecomendationProductEvent {
  final String id;
  const GetRecomendationProductFromScan({required this.id});
}