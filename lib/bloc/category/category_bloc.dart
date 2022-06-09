import 'package:category_repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final CategoryRepository _categoryRepository;

  CategoryBloc(CategoryRepository articleRepository) :
    _categoryRepository = articleRepository,
    super(const CategoryInitialState()) {

    // loading
    on<LoadCategory>(_onLoadCategories);
    on<LoadCategorySuccess>(_onLoadCategoriesSuccess);
    on<LoadCategoryError>(_onLoadCategoriesError);

    // saving
    on<UpdateCategory>(_onUpdateCategory);
    on<UpdateCategoryError>(_onUpdateCategoryError);
  }

  void _onLoadCategories(LoadCategory event, emit) async {
    emit(const CategoryLoadingState());

    ArticleCategory category = await _categoryRepository
      .getCategory(event.categoryId);

    add(LoadCategorySuccess(category));
  }

  void _onLoadCategoriesSuccess(LoadCategorySuccess event, emit) {
    emit(CategoryLoadedState(event.category));
  }

  void _onLoadCategoriesError(LoadCategoryError event, emit) {
    emit(const CategoryLoadingErrorState());
  }

  void _onUpdateCategory(UpdateCategory event, emit) async {
    emit(const CategoryUpdatingState());

    await _categoryRepository.updateCategory(event.articleCategory);

    add(LoadCategorySuccess(event.articleCategory));
  }

  void _onUpdateCategoryError(UpdateCategoryError event, emit) {
    emit(UpdateCategoryError());
  }

}
