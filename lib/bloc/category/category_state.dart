part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {

  final ArticleCategory? category;

  const CategoryState(this.category);

  @override
  List<Object> get props => [];

}

class CategoryInitialState extends CategoryState {
  const CategoryInitialState() : super(null);
}

class CategoryLoadingState extends CategoryState {
  const CategoryLoadingState() : super(null);
}

class CategoryLoadedState extends CategoryState {
  const CategoryLoadedState(ArticleCategory category) : super(category);
}

class CategoryLoadingErrorState extends CategoryState {
  const CategoryLoadingErrorState() : super(null);
}

class CategoryUpdatingState extends CategoryState {
  const CategoryUpdatingState() : super(null);
}