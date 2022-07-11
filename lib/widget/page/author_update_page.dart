import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/author/author_bloc.dart';
import 'package:lazitsapp_admin/widget/author/author_update_form.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';

class AuthorUpdatePage extends StatelessWidget {

  final String authorId;

  const AuthorUpdatePage(this.authorId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<AuthorBloc>(
      create: (BuildContext context) => AuthorBloc(
        FirebaseAuthorRepository(firebaseProvider.firestore),
        FirebaseArticleRepository(firebaseProvider.firestore),
        FirebaseStorageRepository(firebaseProvider.storage)
      )..add(LoadAuthor(authorId)),
      child: const DefaultAppScaffolding(
        body: AuthorUpdatePageDataProvider()
      )
    );

  }

}

class AuthorUpdatePageDataProvider extends StatelessWidget {
  const AuthorUpdatePageDataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorBloc, AuthorState>(
        builder: (BuildContext context, AuthorState state) {

          if (state is AuthorLoadedState) {

            Author author = state.author;

            return ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 512.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Edit Author',
                        style: Theme.of(context).textTheme.headlineSmall
                    ),
                    const SizedBox(height: 16.0),
                    AuthorUpdateForm(author),
                  ],
                ),
              ),
            );
          }

          if (state is AuthorErrorState) {
            return Text(state.errorMessage);
          }

          if (state is AuthorLoadingState) {
            return const Text('loading');
          }

          return const Text('No author to display!');

        }
    );
  }
}
