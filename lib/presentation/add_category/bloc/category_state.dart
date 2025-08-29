part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<CategoryModel> categories;
  final String? errorMessage;

  const CategoryState({
    required this.status,
    required this.categories,
    required this.errorMessage,
  });

  const CategoryState.initial()
    : status = CategoryStatus.initial,
      categories = const [],
      errorMessage = null;

  CategoryState copyWith({
    CategoryStatus? status,
    List<CategoryModel>? categories,
    String? errorMessage,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, errorMessage];
}
