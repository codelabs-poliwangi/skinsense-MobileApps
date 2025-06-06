part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  final bool hasReachedMax;
  const ProductState({this.hasReachedMax = false});

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  Products products;

  ProductLoaded({
    required this.products,
    super.hasReachedMax,
  });
  ProductLoaded copyWith({
    Products? products,
    bool? hasReachedMax,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
}

final class ProductNotFound extends ProductState {
  final String message;
  const ProductNotFound(this.message);
}
