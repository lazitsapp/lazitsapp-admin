import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/widget/article/article.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';
import 'package:lazitsapp_shared/lazitsapp_shared.dart';

class ArticleUpdatePage extends StatelessWidget {

  final String articleId;

  const ArticleUpdatePage(this.articleId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<ArticleBloc>(
      create: (BuildContext context) => ArticleBloc(
        articleRepository: FirebaseArticleRepository(firebaseProvider.firestore),
        storageRepository: FirebaseStorageRepository(firebaseProvider.storage),
      )..add(LoadArticle(articleId)),
      child: const ArticleUpdatePageScaffolding(),
    );
  }
}

class ArticleUpdatePageScaffolding extends StatelessWidget {

  const ArticleUpdatePageScaffolding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultAppScaffolding(
      body: ArticleUpdatePageBody()
    );
  }

}

class ArticleUpdatePageBody extends StatelessWidget {

  const ArticleUpdatePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ArticleBloc, ArticleState>(
        builder: (BuildContext context, ArticleState state) {

          Article? article = state.article;

          if (state is ArticleLoadingState) {
            return const Text('loading');
          } else if (article != null) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 512),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Article',
                        style: Theme.of(context).textTheme.headlineSmall
                      ),
                      ArticleUpdateForm(article),
                      // const Text('Articles in this category'),
                      // CategoryDetailArticles(articleCategory),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text('No category to display');
          }

        }
    );

  }

}
