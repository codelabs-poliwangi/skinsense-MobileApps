part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}
class FetchProducts extends ProductEvent { }

class SearchProduct extends ProductEvent {
  final String query;

  const SearchProduct(this.query);

  @override
  List<Object> get props => [query];
}