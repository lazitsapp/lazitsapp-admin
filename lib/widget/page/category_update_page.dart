import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_shared/lazitsapp_shared.dart';
import 'package:lazitsapp_admin/widget/article/article.dart';
import 'package:lazitsapp_admin/widget/category/category.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';

class CategoryUpdatePage extends StatelessWidget {

  final String categoryId;

  const CategoryUpdatePage(this.categoryId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(
            categoryRepository: FirebaseCategoryRepository(
              firebaseProvider.firestore
            ),
            articleRepository: FirebaseArticleRepository(
              firebaseProvider.firestore
            ),
          )..add(LoadCategory(categoryId)),
        ),
        BlocProvider<ArticlesBloc>(
          create: (context) => ArticlesBloc(
            articleRepository: FirebaseArticleRepository(
              firebaseProvider.firestore
            )
          )..add(LoadArticles(categoryId: categoryId)),
        ),
      ],
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


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {

          if (state is CategoryLoadingState) {
            return const Text('Loading Category');
          }

          if (state is CategoryErrorState) {
            return Text(state.errorMessage);
          }

          if (state is CategoryLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildForm(context),
                buildArticles(context),
              ],
            );
          }

          return const Text('Cannot display category!');

        },
      ),
    );



  }

  Widget buildForm(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {

        if (state is CategoryLoadedState) {
          Category? category = state.category;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Category',
                style: Theme.of(context).textTheme.headlineSmall
              ),
              const SizedBox(height: 16.0),
              CategoryUpdateForm(category),
            ],
          );
        }

        return const Text('No category to display');

      },
    );
  }

  Widget buildArticles(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {

        if (state is ArticlesLoadingState) {
          return const Text('Loading articles for category');
        }

        if (state is ArticlesLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              Text(
                  'Category Articles',
                  style: Theme.of(context).textTheme.headlineSmall
              ),
              const SizedBox(height: 16.0),
              ArticlesList(state.articles),
            ],
          );
        }

        if (state is ArticlesLoadingErrorState) {
          return Text(state.errorMessage);
        }

        return const Text('No articles to display');
      },
    );
  }

}
