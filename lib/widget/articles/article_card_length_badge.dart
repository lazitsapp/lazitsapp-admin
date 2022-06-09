import 'package:article_repository/article_repository.dart';
import 'package:flutter/material.dart';

class ArticleCardLengthBadge extends StatelessWidget {

  final Article article;

  ArticleCardLengthBadge(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int minutesValue = article.mediaLength ~/ 60;
    const String minutesLabel = 'Minute';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Text(
        '$minutesValue $minutesLabel',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w800,
        )
      ),
    );
  }

}
