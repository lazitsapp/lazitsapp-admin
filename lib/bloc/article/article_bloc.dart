import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  final ArticleRepository _articleRepository;

  ArticleBloc(ArticleRepository articleRepository) :
    _articleRepository = articleRepository,
    super(const ArticleInitialState()) {


    on<LoadArticle>(_onLoadArticles);
    on<LoadArticleSuccess>(_onLoadArticleSuccess);
    on<LoadArticleError>(_onLoadArticleError);
  }

  void _onLoadArticles(LoadArticle event, emit) async {
    emit(const ArticleLoadingState());

    Article article = await _articleRepository.getArticle(event.articleId);

    add(LoadArticleSuccess(article));
  }

  void _onLoadArticleSuccess(LoadArticleSuccess event, emit) async {
    emit(ArticleLoadedState(event.article));
  }

  void _onLoadArticleError(LoadArticleError event, emit) {
    emit(const ArticleLoadingErrorState());
  }

}
