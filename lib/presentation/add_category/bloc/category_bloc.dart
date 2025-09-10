import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/core/models/category.dart';
import 'package:mini_wheelz/core/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required CategoryRepository repository})
    : _repository = repository,
      super(const CategoryState.initial()) {
    on<_LoadCategories>(_onLoad);
    on<_AddCategory>(_onAdd);
    on<_EditCategory>(_onEdit);
    on<_DeleteCategory>(_onDelete);
    on<_SubscribeCategories>(_onSubscribe);
  }

  final CategoryRepository _repository;

  Future<void> _onLoad(
    _LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final categories = await _repository.fetchCategories();
      emit(
        state.copyWith(
          status: CategoryStatus.success,
          categories: categories,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdd(_AddCategory event, Emitter<CategoryState> emit) async {
    try {
      await _repository.addCategory(
        name: event.name,
        description: event.description,
      );
      // Optionally reload
      add(const CategoryEvent.load());
    } catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onEdit(_EditCategory event, Emitter<CategoryState> emit) async {
    try {
      await _repository.updateCategory(
        id: event.id,
        name: event.name,
        description: event.description,
      );
      // Reload to get updated data
      add(const CategoryEvent.load());
    } catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDelete(
    _DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await _repository.deleteCategory(event.id);
      // Reload to get updated data
      add(const CategoryEvent.load());
    } catch (e) {
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onSubscribe(_SubscribeCategories event, Emitter<CategoryState> emit) {
    emit(state.copyWith(status: CategoryStatus.loading));
    _repository.watchCategories().listen((categories) {
      add(CategoryEvent.load());
    });
  }
}
