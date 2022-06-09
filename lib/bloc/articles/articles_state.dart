part of 'articles_bloc.dart';

abstract class ArticlesState extends Equatable {
  final List<Article> articles;

  const ArticlesState(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticlesInitialState extends ArticlesState {
  const ArticlesInitialState() : super(const []);
}

class ArticlesLoadingState extends ArticlesState {
  const ArticlesLoadingState() : super(const []);
}

class ArticlesLoadedState extends ArticlesState {
  const ArticlesLoadedState(List<Article> articles) : super(articles);
}

class ArticlesLoadingErrorState extends ArticlesState {
  const ArticlesLoadingErrorState() : super(const []);
}
