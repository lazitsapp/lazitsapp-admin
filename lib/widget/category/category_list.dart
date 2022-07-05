import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import './category_list_item.dart';

class CategoryList extends StatelessWidget {

  final List<Category> categories;

  const CategoryList(
    this.categories,
    {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categories.map((category) => CategoryListItem(category)).toList()
          )
        ]
      ),
    );

  }
}
