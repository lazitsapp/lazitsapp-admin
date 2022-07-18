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

class UpdateArticle extends ArticleEvent {

  final Article article;

  const UpdateArticle(this.article);

  @override
  List<Object> get props => [article];
}

class CreateArticle extends ArticleEvent {

  final Uint8List mediaBytes;

  const CreateArticle({
    required this.mediaBytes
  });

  @override
  List<Object> get props => [mediaBytes];

}

class DeleteArticle extends ArticleEvent {

  const DeleteArticle();

  @override
  List<Object> get props => [];

}
