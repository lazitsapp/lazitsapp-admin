import 'package:article_repository/article_repository.dart';
import 'package:flutter/material.dart';
import './article_card.dart';

class ArticlesList extends StatelessWidget {

  final List<Article> articles;

  const ArticlesList(this.articles, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: articles.map((article) {
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 8.0),
            child: ArticleCard(article),
          );
        }).toList(),
      );
  }

}
