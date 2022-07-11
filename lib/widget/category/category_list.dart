import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categories.map((category) => CategoryListItem(category)).toList()
          )
        ]
      ),
    );

  }
}
