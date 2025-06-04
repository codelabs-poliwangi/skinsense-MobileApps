part of 'get_recomendation_product_bloc.dart';

sealed class GetRecomendationProductState extends Equatable {
  const GetRecomendationProductState();
  
  @override
  List<Object> get props => [];
}

final class GetRecomendationProductInitial extends GetRecomendationProductState {}
