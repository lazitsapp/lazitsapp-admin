import 'package:author_repository/author_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'authors_event.dart';
part 'authors_state.dart';

class AuthorsBloc extends Bloc<AuthorsEvent, AuthorsState> {

  final AuthorRepository _authorRepository;

  AuthorsBloc(AuthorRepository authorRepository)
    : _authorRepository = authorRepository, 
    super(const AuthorsInitialState()) {
    
    on<LoadAuthors>(_onLoadAuthors);
    on<LoadAuthorsSuccess>(_onLoadAuthorsSuccess);
    on<LoadAuthorsError>(_onLoadAuthorsError);
  }
  
  void _onLoadAuthors(LoadAuthors event, emit) async {
    emit(const AuthorsLoadingState());

    List<Author> authors = await _authorRepository
      .getAuthors();

    add(LoadAuthorsSuccess(authors));
  }

  void _onLoadAuthorsSuccess(LoadAuthorsSuccess event, emit) {
    emit(AuthorsLoadedState(event.authors));
  }

  void _onLoadAuthorsError(LoadAuthorsError event, emit) {
    emit(const AuthorsLoadingErrorState());
  }

}
