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

class CreateCategory extends CategoryEvent {

  final String name;
  final CategoryType categoryType;
  final int priority;
  final String shortDescription;
  final bool isActive;
  final VoidCallback? onCompleted;

  const CreateCategory({
    required this.name,
    required this.categoryType,
    required this.priority,
    required this.shortDescription,
    required this.isActive,
    this.onCompleted,
  });

  @override
  List<Object> get props => [
    name,
    categoryType,
    priority,
    shortDescription,
    isActive,
  ];

}

class UpdateCategory extends CategoryEvent {

  final String articleId;
  final String name;
  final CategoryType categoryType;
  final int priority;
  final String shortDescription;
  final bool isActive;
  final VoidCallback? onCompleted;

  const UpdateCategory({
    required this.articleId,
    required this.name,
    required this.categoryType,
    required this.priority,
    required this.shortDescription,
    required this.isActive,
    this.onCompleted,
  });

  @override
  List<Object> get props => [
    articleId,
    name,
    categoryType,
    priority,
    shortDescription,
    isActive,
  ];
}

class DeleteCategory extends CategoryEvent {

  final Category category;
  final VoidCallback? onCompleted;

  const DeleteCategory({
    required this.category,
    this.onCompleted,
  });

  @override
  List<Object> get props => [category];

}
