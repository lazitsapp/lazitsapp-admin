part of 'author_bloc.dart';

abstract class AuthorEvent extends Equatable {
  const AuthorEvent();
}

class LoadAuthor extends AuthorEvent {

  final String authorId;

  const LoadAuthor(this.authorId);

  @override
  List<Object> get props => [authorId];

}

class LoadAuthorSuccess extends AuthorEvent {

  final Author author;

  const LoadAuthorSuccess(this.author);

  @override
  List<Object> get props => [author];

  @override
  String toString() => 'LoadAuthorSuccess { Author: $author }';

}

class LoadAuthorError extends AuthorEvent {
  @override
  List<Object> get props => [];
}

class UpdateAuthor extends AuthorEvent {

  final Author author;

  const UpdateAuthor(this.author);

  @override
  List<Object> get props => [author];
}

class UpdateAuthorWithProfileImage extends AuthorEvent {

  final Author author;
  final Uint8List? imageBytes;

  const UpdateAuthorWithProfileImage(this.author, this.imageBytes);

  @override
  List<Object> get props => [author];
}

class UpdateAuthorSuccess extends AuthorEvent {
  @override
  List<Object> get props => [];
}

class UpdateAuthorError extends AuthorEvent {
  @override
  List<Object> get props => [];
}