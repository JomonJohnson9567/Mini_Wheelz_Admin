part of 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class ProductImagePicked extends ProductEvent {
  const ProductImagePicked({required this.fromCamera});
  final bool fromCamera;
}

class ProductFieldChanged extends ProductEvent {
  const ProductFieldChanged({
    this.name,
    this.price,
    this.quantity,
    this.description,
    this.categoryId,
  });
  final String? name;
  final double? price;
  final int? quantity;
  final String? description;
  final String? categoryId;

  @override
  List<Object?> get props => [name, price, quantity, description, categoryId];
}

class ProductSubmitted extends ProductEvent {
  const ProductSubmitted();
}

class ProductReset extends ProductEvent {
  const ProductReset();
}

class ProductImageRemoved extends ProductEvent {
  const ProductImageRemoved(this.index);
  final int index;
  @override
  List<Object?> get props => [index];
}
