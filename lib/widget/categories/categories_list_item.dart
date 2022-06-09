import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesListItem extends StatelessWidget {

  final ArticleCategory articleCategory;

  const CategoriesListItem(this.articleCategory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(articleCategory.name),
      onPressed: () => GoRouter.of(context).go('/categories/${articleCategory.id}'),
    );
  }

}
