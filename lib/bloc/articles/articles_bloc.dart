import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {

  final ArticleRepository _articleRepository;

  ArticlesBloc({
    required ArticleRepository articleRepository
  }) :
    _articleRepository = articleRepository,
    super(const ArticlesInitialState()) {

    on<LoadArticles>(_onLoadArticles);
  }

  void _onLoadArticles(LoadArticles event, emit) async {
    emit(ArticlesLoadingState());

    try {

      ArticleQueryOptions queryOptions = ArticleQueryOptions(
        categoryId: event.categoryId,
      );

      List<Article> articles =
        await _articleRepository.getArticles(queryOptions);

      emit(ArticlesLoadedState(articles));
    } catch (err) {
      emit(LoadArticlesError(err.toString()));
    }

  }

}

