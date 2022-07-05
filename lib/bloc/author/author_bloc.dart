import 'dart:typed_data';

import 'package:article_repository/article_repository.dart';
import 'package:author_repository/author_repository.dart';
import 'package:flutter/material.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {

  final AuthorRepository _authorRepository;
  final ArticleRepository _articleRepository;
  final StorageRepository _storageRepository;
  
  AuthorBloc(
    AuthorRepository authorRepository,
    ArticleRepository articleRepository,
    StorageRepository storageRepository,
  ) :
    _authorRepository = authorRepository,
    _articleRepository = articleRepository,
    _storageRepository = storageRepository,
    super(AuthorInitialState()) {

    on<LoadAuthor>(_onLoadAuthor);
    on<UpdateAuthor>(_onUpdateAuthor);
    on<CreateAuthor>(_onCreateAuthor);
    on<DeleteAuthor>(_onDeleteAuthor);
  }

  void _onLoadAuthor(LoadAuthor event, emit) async {
    emit(AuthorLoadingState());

    Author author = await _authorRepository
      .getAuthor(event.authorId);

    emit(AuthorLoadedState(author));
  }

  void _onUpdateAuthor(UpdateAuthor event, emit) async {
    emit(AuthorLoadingState());

    Author author = Author(
      authorId: event.authorId,
      displayName: event.displayName,
      title: event.title,
      photoUrl: event.photoUrl,
    );

    final Uint8List? imageBytes = event.imageBytes;

    if (imageBytes != null) {
      UploadTask uploadTask = _storageRepository.storeAuthorProfileImage(
        author.authorId,
        imageBytes,
      );
      await uploadTask.whenComplete(() => null);

      String photoUrl = await uploadTask.snapshot.ref.getDownloadURL();
      author = author.copyWith(
        photoUrl: photoUrl
      );
    }

    debugPrint(author.toString());

    await _authorRepository.updateAuthor(author);
    await _articleRepository.updateAuthorReferences(
      ArticleAuthor(
        author.authorId,
        author.displayName,
        author.title,
        author.photoUrl
      )
    );

    emit(AuthorLoadedState(author));
  }

  void _onCreateAuthor(CreateAuthor event, emit) async {
    emit(AuthorLoadingState());

    String authorId = Author.generateId();

    // upload file
    UploadTask uploadTask = _storageRepository.storeAuthorProfileImage(
      authorId,
      event.imageBytes,
    );
    await uploadTask.whenComplete(() => null);

    String photoUrl = await uploadTask.snapshot.ref.getDownloadURL();

    Author author = Author(
      authorId: authorId,
      displayName: event.displayName,
      title: event.title,
      photoUrl: photoUrl,
    );

    await _authorRepository.setAuthor(author);
    emit(AuthorLoadedState(author));
  }

  void _onDeleteAuthor(DeleteAuthor event, emit) async {

    try {
      emit(AuthorLoadingState());
      bool hasArticles = await _authorRepository.hasArticles(event.author);
      if (hasArticles) {
        throw Exception('Cannot delete author ${event.author.authorId} still having articles associated!');
      } else {
        await _authorRepository.deleteAuthor(event.author);
      }

    } catch (err) {
      emit(AuthorErrorState(err.toString()));
    }

  }

}
