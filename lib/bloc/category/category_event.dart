part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategory extends CategoryEvent {

  final String categoryId;

  const LoadCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class LoadCategorySuccess extends CategoryEvent {
  final ArticleCategory category;
  const LoadCategorySuccess(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'LoadCategorySuccess { category: $category }';
}

class LoadCategoryError extends CategoryEvent {
  @override
  List<Object> get props => [];
}

class UpdateCategory extends CategoryEvent {

  final ArticleCategory articleCategory;

  const UpdateCategory(this.articleCategory);

  @override
  List<Object> get props => [articleCategory];
}

class UpdateCategorySuccess extends CategoryEvent {
  @override
  List<Object> get props => [];
}

class UpdateCategoryError extends CategoryEvent {
  @override
  List<Object> get props => [];
}