import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  final CategoryRepository _categoryRepository;

  CategoriesBloc(CategoryRepository categoryRepository) :
    _categoryRepository = categoryRepository,
    super(const CategoriesInitialState()) {

    on<LoadCategories>(_onLoadCategories);
    on<LoadCategoriesSuccess>(_onLoadCategoriesSuccess);
    on<LoadCategoriesError>(_onLoadCategoriesError);
  }

  void _onLoadCategories(LoadCategories event, emit) async {
    emit(const CategoriesLoadingState());

    List<Category> categories = await _categoryRepository
      .getCategories(const CategoryQueryOptions(
        activeQueryOption: CategoryActiveQueryOption.all,
      ));

    add(LoadCategoriesSuccess(categories));
  }

  void _onLoadCategoriesSuccess(LoadCategoriesSuccess event, emit) {
    emit(CategoriesLoadedState(event.categories));
  }

  void _onLoadCategoriesError(LoadCategoriesError event, emit) {
    emit(const CategoriesLoadingErrorState());
  }

}
