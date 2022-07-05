part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {

  final List<Category> categories;

  const CategoriesState(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoriesInitialState extends CategoriesState {
  const CategoriesInitialState() : super(const []);
}

class CategoriesLoadingState extends CategoriesState {
  const CategoriesLoadingState() : super(const []);
}

class CategoriesLoadedState extends CategoriesState {
  const CategoriesLoadedState(List<Category> categories) : super(categories);
}

class CategoriesLoadingErrorState extends CategoriesState {
  const CategoriesLoadingErrorState() : super(const []);
}