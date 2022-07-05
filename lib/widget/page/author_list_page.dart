import 'package:author_repository/author_repository.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/bloc/authors/authors_bloc.dart';
import 'package:lazitsapp_admin/router/router.dart';
import 'package:lazitsapp_admin/widget/author/author_list.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';

class AuthorListPage extends StatelessWidget {

  const AuthorListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<AuthorsBloc>(
      create: (BuildContext context) => AuthorsBloc(
        FirebaseAuthorRepository(firebaseProvider.firebaseFirestore)
      )..add(const LoadAuthors()),
      child: DefaultAppScaffolding(
        title: AppPage.authorList.title,
        body: const AuthorListPageData(),
        floatingActionButton: FloatingActionButton.large(
          child: const Icon(Icons.add),
          onPressed: () => GoRouter.of(context).go('/authors/create'),
        ),
      )
    );

  }

}

class AuthorListPageData extends StatelessWidget {

  const AuthorListPageData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthorsBloc, AuthorsState>(
      builder: (BuildContext context, AuthorsState state) {

        if (state is AuthorsLoadingState) {
          return const Text('loading');
        }

        if (state is AuthorsLoadedState) {
          debugPrint(state.authors.toString());
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: AuthorList(state.authors),
          );
        }

        return const Text('No authors to display');

      }

    );

  }

}
