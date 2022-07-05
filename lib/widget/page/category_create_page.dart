import 'package:article_repository/article_repository.dart';
import 'package:category_repository/category_repository.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/widget/category/category.dart';
import 'package:provider/provider.dart';

import '../../bloc/category/category_bloc.dart';
import '../../router/app_page.dart';
import '../default_app_scaffolding.dart';

class CategoryCreatePage extends StatelessWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<CategoryBloc>(
        create: (BuildContext context) => CategoryBloc(
          categoryRepository: FirebaseCategoryRepository(firebaseProvider.firebaseFirestore),
          articleRepository: FirebaseArticleRepository(firebaseProvider.firebaseFirestore),
        ),
        child: DefaultAppScaffolding(
          title: AppPage.categoryCreate.title,
          body: const CategoryCreatePageDataProvider()
        )
    );

  }
}

class CategoryCreatePageDataProvider extends StatelessWidget {
  const CategoryCreatePageDataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CategoryBloc, CategoryState>(
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
                  'Create new category',
                  style: Theme.of(context).textTheme.headlineSmall
                ),
                const SizedBox(height: 16.0),
                const CategoryCreateForm(),
              ],
            ),
          ),
        );
      },
    );


  }
}


