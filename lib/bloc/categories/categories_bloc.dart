import 'package:category_repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  final CategoryRepository _categoryRepository;

  CategoriesBloc(CategoryRepository articleRepository) :
    _categoryRepository = articleRepository,
    super(const CategoriesInitialState()) {

    on<LoadCategories>(_onLoadCategories);
    on<LoadCategoriesSuccess>(_onLoadCategoriesSuccess);
    on<LoadCategoriesError>(_onLoadCategoriesError);
  }

  void _onLoadCategories(LoadCategories event, emit) async {
    emit(const CategoriesLoadingState());

    List<ArticleCategory> categories = await _categoryRepository
      .getCategories(isActive: true);

    add(LoadCategoriesSuccess(categories));
  }

  void _onLoadCategoriesSuccess(LoadCategoriesSuccess event, emit) {
    emit(CategoriesLoadedState(event.categories));
  }

  void _onLoadCategoriesError(LoadCategoriesError event, emit) {
    emit(const CategoriesLoadingErrorState());
  }

}
