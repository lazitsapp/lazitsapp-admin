part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class LoadCategories extends CategoriesEvent {

  const LoadCategories();

  @override
  List<Object> get props => [];
}

class LoadCategoriesSuccess extends CategoriesEvent {
  final List<Category> categories;
  const LoadCategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'LoadCategoriesSuccess { category: $categories }';
}

class LoadCategoriesError extends CategoriesEvent {
  @override
  List<Object> get props => [];
}