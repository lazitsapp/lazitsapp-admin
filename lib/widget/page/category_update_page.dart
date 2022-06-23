import 'package:category_repository/category_repository.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/category/category_bloc.dart';
import 'package:lazitsapp_admin/widget/category/category.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';

class CategoryUpdatePage extends StatelessWidget {

  final String categoryId;

  const CategoryUpdatePage(this.categoryId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<CategoryBloc>(
      create: (BuildContext context) => CategoryBloc(
        FirebaseCategoryRepository(firebaseProvider.firebaseFirestore)
      )..add(LoadCategory(categoryId)),
      child: const DefaultAppScaffolding(
        body: CategoryDetailPageDataProvider()
      )
    );

  }
}

class CategoryDetailPageDataProvider extends StatelessWidget {

  const CategoryDetailPageDataProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (BuildContext context, CategoryState state) {

          ArticleCategory? articleCategory = state.category;

          if (state is CategoryLoadingState) {
            return const Text('loading');
          } else if (articleCategory != null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Category',
                    style: Theme.of(context).textTheme.headlineSmall
                  ),
                  const SizedBox(height: 16.0),
                  CategoryUpdateForm(articleCategory),
                  const SizedBox(height: 32.0),
                  Text(
                    'Category Articles',
                    style: Theme.of(context).textTheme.headlineSmall
                  ),
                  const SizedBox(height: 16.0),
                  CategoryUpdateArticles(articleCategory),
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
