import 'package:article_repository/article_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/article/article_bloc.dart';
import 'package:lazitsapp_admin/widget/article_detail/article_detail_form.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';

class ArticleDetailPage extends StatelessWidget {

  final String articleId;

  const ArticleDetailPage(this.articleId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleBloc>(
      create: (BuildContext context) => ArticleBloc(
        FirebaseArticleRepository(FirebaseFirestore.instance)
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
