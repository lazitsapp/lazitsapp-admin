part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();
}

class LoadArticles extends ArticlesEvent {

  final String? categoryId;

  const LoadArticles({
    this.categoryId
  });

  @override
  List<Object> get props => [];
}

class LoadArticlesSuccess extends ArticlesEvent {
  final List<Article> articles;
  const LoadArticlesSuccess(this.articles);

  @override
  List<Object> get props => [articles];

  @override
  String toString() => 'LoadArticlesSuccess { category: $articles }';
}

class LoadArticlesError extends ArticlesEvent {

  final String errorMessage;

  const LoadArticlesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

}