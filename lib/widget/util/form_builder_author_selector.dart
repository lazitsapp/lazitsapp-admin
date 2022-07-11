import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';

import '../../bloc/authors/authors_bloc.dart';

class FormBuilderAuthorSelector extends StatelessWidget {

  final ArticleAuthor? initialValue;

  const FormBuilderAuthorSelector({
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<AuthorsBloc>(
      create: (context) => AuthorsBloc(
        FirebaseAuthorRepository(firebaseProvider.firestore)
      )..add(const LoadAuthors()),
      child: _FormBuilderAuthorSelectorInput(
        initialValue: initialValue,
      ),
    );
  }

}

class _FormBuilderAuthorSelectorInput extends StatelessWidget {

  final ArticleAuthor? initialValue;

  const _FormBuilderAuthorSelectorInput({
    this.initialValue,
    Key? key,
  }) : super(key: key);

  Author? getInitialValueAuthor(List<Author> authors, ArticleAuthor? initialValue) {

    if (initialValue == null) {
      return null;
    }

    return authors.firstWhere((author) {
      return (initialValue.id == author.authorId);
    });

  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthorsBloc, AuthorsState>(
      builder: (context, state) {

        if (state is AuthorsLoadedState) {
          return FormBuilderDropdown<Author>(
            name: 'author',
            decoration: const InputDecoration(labelText: 'Author'),
            initialValue: getInitialValueAuthor(state.authors, initialValue),
            items: state.authors.map((author) {
              return DropdownMenuItem<Author>(
                value: author,
                child: Text(author.displayName),
              );
            }).toList(),
          );
        }

        return const Text('unable to display');

      },
    );


  }

}

