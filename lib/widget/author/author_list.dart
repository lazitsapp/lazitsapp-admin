import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter/material.dart';
import 'package:lazitsapp_admin/widget/author/author_list_item.dart';
import 'package:lazitsapp_admin/widget/util/intersperse.dart';

class AuthorList extends StatelessWidget {

  final List<Author> authors;

  const AuthorList(this.authors, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Authors', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Row(
          children: intersperseWidgets(const SizedBox(width: 16), authors.map((author) {
            return AuthorListItem(author);
          })).toList(),
        )
      ],
    );

  }

}
