part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  const factory CategoryEvent.load() = _LoadCategories;
  const factory CategoryEvent.add({
    required String name,
    required String description,
  }) = _AddCategory;
  const factory CategoryEvent.subscribe() = _SubscribeCategories;

  @override
  List<Object?> get props => [];
}

class _LoadCategories extends CategoryEvent {
  const _LoadCategories();
}

class _AddCategory extends CategoryEvent {
  final String name;
  final String description;
  const _AddCategory({required this.name, required this.description});

  @override
  List<Object?> get props => [name, description];
}

class _SubscribeCategories extends CategoryEvent {
  const _SubscribeCategories();
}
