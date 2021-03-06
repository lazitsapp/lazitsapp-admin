import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/author/author_bloc.dart';
import 'package:lazitsapp_admin/router/router.dart';
import 'package:lazitsapp_admin/widget/author/author_create_form.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';

class AuthorCreatePage extends StatelessWidget {
  const AuthorCreatePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<AuthorBloc>(
      create: (BuildContext context) => AuthorBloc(
        FirebaseAuthorRepository(firebaseProvider.firestore),
        FirebaseArticleRepository(firebaseProvider.firestore),
        FirebaseStorageRepository(firebaseProvider.storage)
      ),
      child: DefaultAppScaffolding(
        title: AppPage.authorCreate.title,
        body: const AuthorCreatePageDataProvider()
      )
    );

  }

}

class AuthorCreatePageDataProvider extends StatelessWidget {
  const AuthorCreatePageDataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorBloc, AuthorState>(
      builder: (BuildContext context, AuthorState state) {
        return ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 512.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create new author',
                  style: Theme.of(context).textTheme.headlineSmall
                ),
                const SizedBox(height: 16.0),
                const AuthorCreateForm(),
              ],
            ),
          ),
        );
      }
    );
  }
}