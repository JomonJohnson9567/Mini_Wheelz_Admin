import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_wheelz/core/models/product.dart';
import 'package:mini_wheelz/core/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepository repository})
    : _repository = repository,
      super(const ProductState()) {
    on<ProductImagePicked>(_onImagePicked);
    on<ProductFieldChanged>(_onFieldChanged);
    on<ProductSubmitted>(_onSubmitted);
    on<ProductReset>(_onReset);
    on<ProductImageRemoved>(_onImageRemoved);
  }

  final ProductRepository _repository;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImagePicked(
    ProductImagePicked event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final source = event.fromCamera
          ? ImageSource.camera
          : ImageSource.gallery;
      if (state.images.length >= 4) return;
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (picked == null) return;
      final files = List<File>.from(state.images)..add(File(picked.path));
      if (files.length > 4) files.removeRange(4, files.length);
      emit(state.copyWith(images: files));
    } catch (e) {
      emit(
        state.copyWith(status: ProductStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onFieldChanged(ProductFieldChanged event, Emitter<ProductState> emit) {
    emit(
      state.copyWith(
        name: event.name ?? state.name,
        price: event.price ?? state.price,
        quantity: event.quantity ?? state.quantity,
        description: event.description ?? state.description,
        categoryId: event.categoryId ?? state.categoryId,
      ),
    );
  }

  Future<void> _onSubmitted(
    ProductSubmitted event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading, errorMessage: null));
      if (state.name.trim().isEmpty ||
          state.categoryId.trim().isEmpty ||
          state.price <= 0 ||
          state.quantity < 0) {
        throw Exception('Please fill all required fields');
      }

      final imageUrls = state.images.isEmpty
          ? <String>[]
          : await _repository.uploadImages(
              categoryId: state.categoryId,
              productName: state.name,
              images: state.images,
            );

      final product = ProductModel(
        id: '',
        name: state.name,
        price: state.price,
        quantity: state.quantity,
        description: state.description,
        categoryId: state.categoryId,
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
      );

      await _repository.addProduct(
        categoryId: state.categoryId,
        product: product,
      );

      emit(state.copyWith(status: ProductStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: ProductStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onReset(ProductReset event, Emitter<ProductState> emit) {
    emit(const ProductState());
  }

  void _onImageRemoved(ProductImageRemoved event, Emitter<ProductState> emit) {
    if (event.index < 0 || event.index >= state.images.length) return;
    final files = List<File>.from(state.images)..removeAt(event.index);
    emit(state.copyWith(images: files));
  }
}
