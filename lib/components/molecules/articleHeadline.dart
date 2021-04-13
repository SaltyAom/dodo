import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/article/models.dart';
import 'package:dodo/bloc/navigator/navigator.dart';

import 'package:dodo/components/atoms/articleImage.dart';

class ArticleHeadline extends StatelessWidget {
  final ArticleMetadata article;

  const ArticleHeadline(
    this.article, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorBloc = context.read<NavigatorBloc>();

    final theme = Theme.of(context);
    final variants = theme.textTheme;

    return NikuColumn([
      ArticleImage(article.image).niku()..aspectRatio(16 / 10),
      Text(
        article.title,
        style: variants.headline2,
      ).niku()
        ..my(4)
        ..mb(4),
      Text(
        "${article.author} ー ${article.date}",
        style: variants.headline6,
      ),
    ]).crossStart().niku()
      ..on(tap: () async {
        navigatorBloc.add(
          NavigatorAppendPage(
            await createArticlePage(article),
          ),
        );
      })
      ..my(12);
  }
}
