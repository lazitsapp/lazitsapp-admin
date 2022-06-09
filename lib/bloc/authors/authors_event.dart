part of 'authors_bloc.dart';

abstract class AuthorsEvent extends Equatable {
  const AuthorsEvent();
}

class LoadAuthors extends AuthorsEvent {

  const LoadAuthors();

  @override
  List<Object> get props => [];

}

class LoadAuthorsSuccess extends AuthorsEvent {

  final List<Author> authors;

  const LoadAuthorsSuccess(this.authors);

  @override
  List<Object> get props => [authors];

  @override
  String toString() => 'LoadAuthorsSuccess { authors: $authors }';

}

class LoadAuthorsError extends AuthorsEvent {
  @override
  List<Object> get props => [];
}