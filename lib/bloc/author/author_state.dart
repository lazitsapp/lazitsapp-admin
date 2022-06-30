part of 'author_bloc.dart';

abstract class AuthorState extends Equatable {
  const AuthorState();
}

class AuthorInitialState extends AuthorState {
  @override
  List<Object> get props => [];
}

class AuthorLoadingState extends AuthorState {
  @override
  List<Object> get props => [];
}

class AuthorLoadedState extends AuthorState {

  final Author author;

  const AuthorLoadedState(this.author);

  @override
  List<Object> get props => [author];

}

class AuthorErrorState extends AuthorState {

  final String errorMessage;
  const AuthorErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

}
