import 'package:article_repository/article_repository.dart';
import 'package:category_repository/category_repository.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/articles/articles_bloc.dart';
import 'package:lazitsapp_admin/widget/articles/articles_list.dart';
import 'package:provider/provider.dart';

class CategoryDetailArticles extends StatelessWidget {

  final ArticleCategory articleCategory;

  const CategoryDetailArticles(
    this.articleCategory,
    {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<ArticlesBloc>(
      create: (BuildContext context) => ArticlesBloc(
        FirebaseArticleRepository(firebaseProvider.firebaseFirestore)
      )..add(LoadArticles(articleCategory.id)),
      child: const CategoryDetailArticleDataProvider()
    );

  }

}

class CategoryDetailArticleDataProvider extends StatelessWidget {

  const CategoryDetailArticleDataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container();

  }

}

