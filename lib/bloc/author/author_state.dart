part of 'author_bloc.dart';

abstract class AuthorState extends Equatable {
  
  final Author? author;
  
  const AuthorState(this.author);

  @override
  List<Object> get props => [];
}

class AuthorInitialState extends AuthorState {
  const AuthorInitialState() : super(null);
}

class AuthorLoadingState extends AuthorState {
  const AuthorLoadingState() : super(null);
}

class AuthorLoadedState extends AuthorState {
  const AuthorLoadedState(Author author) : super(author);
}

class AuthorLoadingErrorState extends AuthorState {
  const AuthorLoadingErrorState() : super(null);
}

class AuthorUpdatingState extends AuthorState {
  const AuthorUpdatingState() : super(null);
}