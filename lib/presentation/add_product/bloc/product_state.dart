part of 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';

enum ProductStatus { initial, loading, success, error }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.name = '',
    this.price = 0,
    this.quantity = 0,
    this.description = '',
    this.categoryId = '',
    this.images = const [],
    this.errorMessage,
  });

  final ProductStatus status;
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String categoryId;
  final List<File> images;
  final String? errorMessage;

  ProductState copyWith({
    ProductStatus? status,
    String? name,
    double? price,
    int? quantity,
    String? description,
    String? categoryId,
    List<File>? images,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      images: images ?? this.images,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    name,
    price,
    quantity,
    description,
    categoryId,
    images,
    errorMessage,
  ];
}
