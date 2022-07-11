import 'package:firebase_provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lazitsapp_admin/bloc/categories/categories_bloc.dart';
import 'package:provider/provider.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';

class FormBuilderCategorySelector extends StatelessWidget {

  final ArticleCategory? initialValue;

  const FormBuilderCategorySelector({
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseProvider firebaseProvider = Provider.of<FirebaseProvider>(context);

    return BlocProvider<CategoriesBloc>(
      create: (context) => CategoriesBloc(
        FirebaseCategoryRepository(firebaseProvider.firestore)
      )..add(const LoadCategories()),
      child: _FormBuilderCategorySelectorInput(
        initialValue: initialValue
      ),
    );

  }
}

class _FormBuilderCategorySelectorInput extends StatelessWidget {

  final ArticleCategory? initialValue;

  const _FormBuilderCategorySelectorInput({
    this.initialValue,
    Key? key,
  }) : super(key: key);

  Category? getInitialValueCategory(List<Category> categories, ArticleCategory? initialValue) {

    if (initialValue == null) {
      return null;
    }

    try {
      return categories.firstWhere((category) {
        return (initialValue.categoryId == category.categoryId);
      });
    } catch (_) {
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {

        if (state is CategoriesLoadedState) {
          return FormBuilderDropdown<Category>(
            name: 'category',
            decoration: const InputDecoration(labelText: 'Category'),
            initialValue: getInitialValueCategory(state.categories, initialValue),
            items: state.categories.map((category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
          );
        }

        return Container();
      },
    );

  }
}

