part of 'authors_bloc.dart';

abstract class AuthorsState extends Equatable {
  
  final List<Author> authors;
  
  const AuthorsState(this.authors);

  @override
  List<Object> get props => [authors];
}

class AuthorsInitialState extends AuthorsState {
  
  const AuthorsInitialState() : super(const []);
  
  @override
  List<Object> get props => [];
}

class AuthorsLoadingState extends AuthorsState {
  const AuthorsLoadingState() : super(const []);
}

class AuthorsLoadedState extends AuthorsState {
  const AuthorsLoadedState(List<Author> authors) : super(authors);
}

class AuthorsLoadingErrorState extends AuthorsState {
  const AuthorsLoadingErrorState() : super(const []);
}