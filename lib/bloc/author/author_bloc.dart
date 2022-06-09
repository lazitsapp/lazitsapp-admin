import 'dart:typed_data';

import 'package:author_repository/author_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {

  final AuthorRepository _authorRepository;
  final StorageRepository _storageRepository;
  
  AuthorBloc(
    AuthorRepository authorRepository,
    StorageRepository storageRepository
  ) :
    _authorRepository = authorRepository,
    _storageRepository = storageRepository,
    super(const AuthorInitialState()) {

    on<LoadAuthor>(_onLoadAuthor);
    on<LoadAuthorSuccess>(_onLoadAuthorSuccess);
    on<LoadAuthorError>(_onLoadAuthorError);

    on<UpdateAuthor>(_onUpdateAuthor);
    on<UpdateAuthorWithProfileImage>(_onUpdateAuthorWithProfileImage);
    on<UpdateAuthorError>(_onUpdateAuthorError);
  }

  void _onLoadAuthor(LoadAuthor event, emit) async {
    emit(const AuthorLoadingState());

    Author author = await _authorRepository
      .getAuthor(event.authorId);

    add(LoadAuthorSuccess(author));
  }

  void _onLoadAuthorSuccess(LoadAuthorSuccess event, emit) {
    emit(AuthorLoadedState(event.author));
  }

  void _onLoadAuthorError(LoadAuthorError event, emit) {
    emit(const AuthorLoadingErrorState());
  }

  void _onUpdateAuthor(UpdateAuthor event, emit) async {
    emit(const AuthorUpdatingState());

    await _authorRepository.updateAuthor(event.author);

    add(LoadAuthorSuccess(event.author));
  }

  void _onUpdateAuthorWithProfileImage(
    UpdateAuthorWithProfileImage event,
    emit
  ) async {
    emit(const AuthorUpdatingState());

    UploadTask uploadTask = _storageRepository.storeAuthorProfileImage(
      event.author.authorId,
      event.imageBytes,
    );

    await uploadTask.whenComplete(() => null);






  }

  void _onUpdateAuthorError(UpdateAuthorError event, emit) {
    emit(UpdateAuthorError());
  }

}
