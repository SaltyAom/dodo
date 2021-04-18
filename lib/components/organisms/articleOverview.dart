import 'package:dodo/components/atoms/retry.dart';
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

    final articleBloc = context.read<ArticleBloc>();

    final refresh = () async {
      articleBloc.add(
        ArticleFetchHeadline(
          headline: headline,
          toOverride: true,
        ),
      );
    };

    if (articleGroup.error)
      return NikuColumn([
        NikuText(articleGroup.errorMessage!)
          ..fontSize(18)
          ..center(),
        RetryButton(onPressed: refresh),
      ]).mainCenter().niku()
        ..px(20);

    final articles = articleGroup.articles!;

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
      onRefresh: refresh,
    );
  }
}
