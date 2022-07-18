import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/widget/article/article_create_form.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:provider/provider.dart';

import 'package:lazitsapp_shared/lazitsapp_shared.dart';
import '../../router/app_page.dart';
import '../default_app_scaffolding.dart';

class ArticleCreatePage extends StatelessWidget {
  const ArticleCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<ArticleBloc>(
        create: (BuildContext context) => ArticleBloc(
          articleRepository: FirebaseArticleRepository(firebaseProvider.firestore),
          storageRepository: FirebaseStorageRepository(firebaseProvider.storage),
        ),
        child: const ArticleCreatePageScaffolding()
    );
  }
}

class ArticleCreatePageScaffolding extends StatelessWidget {
  const ArticleCreatePageScaffolding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppScaffolding(
      title: AppPage.categoryCreate.title,
      body: const ArticleCreatePageBody()
    );
  }
}

class ArticleCreatePageBody extends StatelessWidget {
  const ArticleCreatePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        return ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 512.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create new article',
                  style: Theme.of(context).textTheme.headlineSmall
                ),
                const SizedBox(height: 16.0),
                const ArticleCreateForm(),
              ],
            ),
          ),
        );
      },
    );

  }
}

