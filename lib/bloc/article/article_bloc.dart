import 'dart:typed_data';

import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  final ArticleRepository _articleRepository;
  final StorageRepository _storageRepository;

  ArticleBloc({
    required ArticleRepository articleRepository,
    required StorageRepository storageRepository,
  }) :
    _articleRepository = articleRepository,
    _storageRepository = storageRepository,
    super(const ArticleInitialState()) {


    on<LoadArticle>(_onLoadArticle);
    on<CreateArticle>(_onCreateArticle);
  }

  void _onLoadArticle(LoadArticle event, emit) async {
    emit(const ArticleLoadingState());

    Article article = await _articleRepository.getArticle(event.articleId);

    emit(ArticleLoadedState(article));
  }

  void _onCreateArticle(CreateArticle event, emit) async {
    // emit(ArticleLoadedState(event.article));

    // await _storageRepository.storeArticleMedia(event.mediaBytes);


  }

  // void _onLoadArticleError(LoadArticleError event, emit) {
  //   emit(const ArticleLoadingErrorState());
  // }

}
