part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitialState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryCreatingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryUpdatingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryDeleting extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {

  final Category category;

  const CategoryLoadedState(this.category);

  @override
  List<Object> get props => [category];
}

class CategoryErrorState extends CategoryState {

  final String errorMessage;

  const CategoryErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
