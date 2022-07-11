import 'dart:ui';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final ArticleRepository _articleRepository;
  final CategoryRepository _categoryRepository;

  CategoryBloc({
    required CategoryRepository categoryRepository,
    required ArticleRepository articleRepository,
  }) :
    _articleRepository = articleRepository,
    _categoryRepository = categoryRepository,
    super(CategoryInitialState()) {

    on<LoadCategory>(_onLoadCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<CreateCategory>(_onCreateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  void _onLoadCategory(LoadCategory event, emit) async {
    emit(CategoryLoadingState());

    Category category = await _categoryRepository
      .getCategory(event.categoryId);

    emit(CategoryLoadedState(category));
  }

  void _onUpdateCategory(UpdateCategory event, emit) async {
    emit(CategoryLoadingState());

    Category articleCategory = Category(
      categoryId: event.articleId,
      name: event.name,
      categoryType: event.categoryType,
      priority: event.priority,
      shortDescription: event.shortDescription,
      isActive: event.isActive
    );

    await _categoryRepository.update(articleCategory);

    emit(CategoryLoadedState(articleCategory));

    if (event.onCompleted != null) {
      event.onCompleted!();
    }
  }

  void _onCreateCategory(CreateCategory event, emit) {
    emit(CategoryCreatingState());

    Category category = Category(
      categoryId: Category.generateId(),
      name: event.name,
      shortDescription: event.shortDescription,
      categoryType: event.categoryType,
      priority: event.priority,
      isActive: event.isActive,
    );

    _categoryRepository.create(category);

    emit(CategoryInitialState());

    if (event.onCompleted != null) {
      event.onCompleted!();
    }
  }

  void _onDeleteCategory(DeleteCategory event, emit) async {

    try {
      emit(CategoryLoadingState());

      List<Article> categoryArticles = await _articleRepository.getArticles(
        ArticleQueryOptions(
          categoryId: event.category.categoryId,
          limit: 1,
        )
      );

      bool hasArticles = categoryArticles.isNotEmpty;
      if (hasArticles) {
        throw Exception('Cannot delete author ${event.category.categoryId} still having articles associated!');
      } else {
        await _categoryRepository.delete(event.category);
      }

      if (event.onCompleted != null) {
        event.onCompleted!();
      }

    } catch (err) {
      emit(CategoryErrorState(err.toString()));
    }

  }

}
