import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/widget/util/Avatar.dart';

class AuthorListItem extends StatelessWidget {

  final Author author;

  const AuthorListItem(this.author, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).go('/authors/update/${author.authorId}');
        },
        child: Column(
          children: [
            Avatar(photoUrl: author.photoUrl, size: 96),
            const SizedBox(height: 8),
            Text(author.displayName)
          ],
        ),
      ),
    );

  }
}
