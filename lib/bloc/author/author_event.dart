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

class AuthorLoadingEvent extends AuthorEvent {
  @override
  List<Object> get props => [];
}

class AuthorErrorEvent extends AuthorEvent {

  final String? errorMessage;

  const AuthorErrorEvent(this.errorMessage);

  @override
  List<Object> get props => [];

}

class CreateAuthor extends AuthorEvent {

  final String displayName;
  final String title;
  final Uint8List imageBytes;

  const CreateAuthor({
    required this.displayName,
    required this.title,
    required this.imageBytes,
  });

  @override
  List<Object> get props => [
    displayName,
    title,
    imageBytes,
  ];

}

class UpdateAuthor extends AuthorEvent {

  final String authorId;
  final String displayName;
  final String title;
  final String photoUrl;
  final Uint8List? imageBytes;

  const UpdateAuthor({
    required this.authorId,
    required this.displayName,
    required this.title,
    required this.photoUrl,
    this.imageBytes,
  });

  @override
  List<Object> get props => [
    authorId,
    displayName,
    title,
    photoUrl,
  ];

}

class UpdateAuthorSuccess extends AuthorEvent {
  @override
  List<Object> get props => [];
}

class DeleteAuthor extends AuthorEvent {

  final Author author;

  const DeleteAuthor(this.author);

  @override
  List<Object> get props => [author];
}