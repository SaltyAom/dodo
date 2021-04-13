import 'package:flutter/material.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/article/models.dart';

import 'package:dodo/components/atoms/articleImage.dart';

class ArticlePage extends StatelessWidget {
  final ArticleMetadata article;

  const ArticlePage(this.article);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: NikuColumn([
        Text(
          article.title,
          style: textTheme.headline1,
        ).niku().my(16),
        Text(
          "${article.date} ー ${article.author}",
          style: textTheme.headline6,
        ),
        ArticleImage(article.image).niku().my(16),
      ]).stretch().niku()
        ..scrollable()
        ..px(16),
    );
  }
}
