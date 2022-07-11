import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/router/app_page.dart';
import 'package:lazitsapp_admin/widget/article/article.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';
import 'package:lazitsapp_admin/bloc/articles/articles_bloc.dart';

class ArticleListPage extends StatelessWidget {

  const ArticleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<ArticlesBloc>(
      create: (context) => ArticlesBloc(
        articleRepository: FirebaseArticleRepository(
          firebaseProvider.firestore
        )
      )..add(const LoadArticles()),
      child: const ArticleListPageScaffold(),
    );

  }

}

class ArticleListPageScaffold extends StatelessWidget {
  const ArticleListPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppScaffolding(
      body: const ArticleListPageBody(),
      floatingActionButton: FloatingActionButton.large(
        child: const Icon(Icons.add),
        onPressed: () => GoRouter.of(context).go(AppPage.articleCreate.path)
      )
    );
  }
}

class ArticleListPageBody extends StatelessWidget {
  const ArticleListPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {

        if (state is ArticlesLoadingState) {
          return const Text('loading');
        }

        if (state is ArticlesLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Articles', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                ArticlesList(state.articles),
              ],
            )
          );
        }

        return const Text('No articles to display');

      },
    );

  }
}

