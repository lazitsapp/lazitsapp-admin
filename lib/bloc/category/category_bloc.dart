import 'package:article_repository/article_repository.dart';
import 'package:category_repository/category_repository.dart';
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
  }

  void _onCreateCategory(CreateCategory event, emit) {
    emit(CategoryLoadingState());

    Category articleCategory = Category(
      categoryId: Category.generateId(),
      name: event.name,
      shortDescription: event.shortDescription,
      categoryType: event.categoryType,
      priority: event.priority,
      isActive: event.isActive,
    );

    _categoryRepository.create(articleCategory);

    emit(CategoryLoadedState(articleCategory));
  }

  void _onDeleteCategory(DeleteCategory event, emit) async {

    try {
      emit(CategoryLoadingState());

      List<Article> categoryArticles = await _articleRepository.getArticles(
        categoryId: event.articleCategory.categoryId,
        limit: 1,
      );

      bool hasArticles = categoryArticles.isNotEmpty;
      if (hasArticles) {
        throw Exception('Cannot delete author ${event.articleCategory.categoryId} still having articles associated!');
      } else {
        await _categoryRepository.delete(event.articleCategory);
      }

    } catch (err) {
      emit(CategoryErrorState(err.toString()));
    }

  }

}
