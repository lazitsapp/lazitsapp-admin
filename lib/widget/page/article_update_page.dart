import 'package:article_repository/article_repository.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/article/article_bloc.dart';
import 'package:lazitsapp_admin/widget/article/article.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';

class ArticleUpdatePage extends StatelessWidget {

  final String articleId;

  const ArticleUpdatePage(this.articleId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<ArticleBloc>(
      create: (BuildContext context) => ArticleBloc(
          FirebaseArticleRepository(firebaseProvider.firebaseFirestore)
      )..add(LoadArticle(articleId)),
      child: const DefaultAppScaffolding(
          body: ArticleDetailPageDataProvider()
      ),
    );
  }
}

class ArticleDetailPageDataProvider extends StatelessWidget {

  const ArticleDetailPageDataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ArticleBloc, ArticleState>(
        builder: (BuildContext context, ArticleState state) {

          Article? article = state.article;

          if (state is ArticleLoadingState) {
            return const Text('loading');
          } else if (article != null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
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
            );
          } else {
            return const Text('No category to display');
          }

        }
    );

  }

}
