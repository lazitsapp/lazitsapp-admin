import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_shared/lazitsapp_shared.dart';
import 'package:lazitsapp_admin/widget/category/category.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<CategoriesBloc>(
      create: (BuildContext context) =>
      CategoriesBloc(
        FirebaseCategoryRepository(firebaseProvider.firestore)
      )..add(const LoadCategories()),
      child: const CategoryListPageScaffold()
    );
  }

}

class CategoryListPageScaffold extends StatelessWidget {
  const CategoryListPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppScaffolding(
      body: const CategoryListPageBody(),
      floatingActionButton: FloatingActionButton.large(
        child: const Icon(Icons.add),
        onPressed: () => GoRouter.of(context).go('/categories/create'),
      ),
    );
  }

}


class CategoryListPageBody extends StatelessWidget {
  const CategoryListPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return const Text('loading');
        }

        if (state is CategoriesLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                CategoryList(state.categories)
              ]
            ),
          );
        }

        return const Text('No authors to display');
      },
    );
  }
}
