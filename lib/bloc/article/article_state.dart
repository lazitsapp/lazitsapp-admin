part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {

  final Article? article;

  const ArticleState(this.article);

  @override
  List<Object> get props => [];
}

class ArticleInitialState extends ArticleState {

  const ArticleInitialState() : super(null);
}

class ArticleLoadingState extends ArticleState {
  const ArticleLoadingState() : super(null);
}

class ArticleLoadedState extends ArticleState {
  const ArticleLoadedState(Article article) : super(article);
}

class ArticleLoadingErrorState extends ArticleState {
  const ArticleLoadingErrorState() : super(null);
}
