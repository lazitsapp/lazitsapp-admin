import 'package:category_repository/category_repository.dart';
import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/categories/categories_bloc.dart';
import 'package:lazitsapp_admin/widget/category/category.dart';
import 'package:lazitsapp_admin/widget/default_app_scaffolding.dart';
import 'package:provider/provider.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<CategoriesBloc>(
      create: (BuildContext context) => CategoriesBloc(
        FirebaseCategoryRepository(firebaseProvider.firebaseFirestore)
      )..add(const LoadCategories()),
      child: const DefaultAppScaffolding(
        body: CategoryList()
      )
    );

  }

}
