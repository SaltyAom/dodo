import 'package:dodo/components/atoms/retry.dart';
import 'package:dodo/graphql/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
        Query(
          options: QueryOptions(
            document: gql(getArticleData),
            variables: {
              "title": article.title,
            },
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.hasException)
              return NikuColumn([
                Text(result.exception.toString()),
                RetryButton(
                  onPressed: refetch!,
                ),
              ]);

            if (result.isLoading)
              return CircularProgressIndicator().niku()
                ..center()
                ..mt(80);

            final pageData = result.data!['searchArticle'][0]['data'];

            if (pageData == null) return Text("Something went wrong");

            return MarkdownBody(
              data: pageData,
              shrinkWrap: true,
            );
          },
        ),
      ]).stretch().niku()
        ..scrollable()
        ..px(16),
    );
  }
}
