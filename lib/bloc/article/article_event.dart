part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class LoadArticle extends ArticleEvent {

  final String articleId;

  const LoadArticle(this.articleId);

  @override
  List<Object> get props => [articleId];

}

class LoadArticleSuccess extends ArticleEvent {

  final Article article;

  const LoadArticleSuccess(this.article);

  @override
  List<Object> get props => [article];

  @override
  String toString() => 'LoadCategorySuccess { category: $article }';
}

class LoadArticleError extends ArticleEvent {

  @override
  List<Object> get props => [];

}

class UpdateArticle extends ArticleEvent {

  final Article article;

  const UpdateArticle(this.article);

  @override
  List<Object> get props => [article];
}

class UpdateArticleSuccess extends ArticleEvent {
  @override
  List<Object> get props => [];
}

class UpdateArticleError extends ArticleEvent {
  @override
  List<Object> get props => [];
}
