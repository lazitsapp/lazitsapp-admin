part of 'author_bloc.dart';

abstract class AuthorState extends Equatable {
  const AuthorState();
}

class AuthorInitial extends AuthorState {
  @override
  List<Object> get props => [];
}
