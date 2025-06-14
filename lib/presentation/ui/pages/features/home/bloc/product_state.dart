  part of 'product_bloc.dart';

  sealed class ProductState extends Equatable {
    const ProductState();
    
    @override
    List<Object> get props => [];
  }

  final class ProductInitial extends ProductState {}


  final class ProductLoading extends ProductState {}

  final class ProductLoaded extends ProductState{
    Products products;

    ProductLoaded(this.products);
  }

  final class ProductError extends ProductState {
    final String message;

    const ProductError(this.message);

  }