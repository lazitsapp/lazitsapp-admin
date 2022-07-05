part of 'articles_bloc.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();
}

class ArticlesInitialState extends ArticlesState {
  const ArticlesInitialState();

  @override
  List<Object?> get props => [];
}

class ArticlesLoadingState extends ArticlesState {
  @override
  List<Object?> get props => [];
}

class ArticlesLoadedState extends ArticlesState {
  final List<Article> articles;

  const ArticlesLoadedState(this.articles);

  @override
  List<Object?> get props => [articles];
}

class ArticlesLoadingErrorState extends ArticlesState {

  final String errorMessage;

  const ArticlesLoadingErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
