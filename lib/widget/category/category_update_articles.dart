import 'package:article_repository/article_repository.dart';
import 'package:category_repository/category_repository.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/articles/articles_bloc.dart';
import 'package:provider/provider.dart';

class CategoryUpdateArticles extends StatelessWidget {

  final Category articleCategory;

  const CategoryUpdateArticles(
    this.articleCategory,
    {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container();

    // FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);
    //
    // return BlocProvider<ArticlesBloc>(
    //   create: (BuildContext context) => ArticlesBloc(
    //     FirebaseArticleRepository(firebaseProvider.firebaseFirestore)
    //   )..add(LoadArticles(articleCategory.categoryId)),
    //   child: const CategoryDetailArticleDataProvider()
    // );

  }

}

class CategoryDetailArticleDataProvider extends StatelessWidget {

  const CategoryDetailArticleDataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container();

  }

}

