import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/article/article.dart';

import 'package:dodo/components/molecules/articleHeadline.dart';

class ArticleOverview extends StatelessWidget {
  final ArticleGroup articleGroup;
  final ArticleHeadlineType headline;

  const ArticleOverview({
    Key? key,
    required this.headline,
    required this.articleGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!articleGroup.isLoaded)
      return CircularProgressIndicator().niku()..center();

    if (articleGroup.error)
      return Text(articleGroup.errorMessage!).niku()..center();

    final articleBloc = context.read<ArticleBloc>();

    final articles = articleGroup.articles!;

    final pullToRefresh = () async {
      articleBloc.add(
        ArticleFetchHeadline(
          headline: headline,
          toOverride: true,
        ),
      );
    };

    return RefreshIndicator(
      child: NikuColumn([
        Text(
          articleHeadline[headline] ?? "",
          style: Theme.of(context).textTheme.headline1,
        ).niku()
          ..mt(20),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];

            return ArticleHeadline(
              article,
              key: Key(article.title),
            );
          },
        )
      ]).crossStart().niku()
        ..px(16)
        ..scrollable(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onRefresh: pullToRefresh,
    );
  }
}
