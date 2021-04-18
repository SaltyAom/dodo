import 'package:dodo/graphql/graphql.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:dodo/graphql/modules/articles/queries.dart';

import '../models.dart';

typedef QueryArticle = Future<ArticleGroup> Function(String, String);

final QueryArticle queryArticle = (key, query) async {
  final queryResult = await client.query(
    QueryOptions(
      document: gql(query),
    ),
  );

  if (queryResult.hasException) {
    print(queryResult.exception?.linkException);

    final exception = queryResult.exception!;

    final hasGraphQLError = exception.graphqlErrors.length > 0;

    return ArticleGroup(
      isLoaded: true,
      error: true,
      errorMessage: hasGraphQLError
          ? exception.graphqlErrors.map((error) => error.message).join("\n")
          : exception.linkException != null
              ? exception.linkException.toString()
              : "Something Went Wrong",
      articles: null,
    );
  }

  final List<dynamic> articles = queryResult.data![key];

  return ArticleGroup(
    isLoaded: true,
    articles: articles
        .map(
          (article) => ArticleMetadata.fromJson(article),
        )
        .toList(),
  );
};

final Future<ArticleGroup> Function() getTrendings =
    () async => await queryArticle(
          'getTrendings',
          getTrendingArticles,
        );

final Future<ArticleGroup> Function() getLatests =
    () async => await queryArticle(
          'getLatests',
          getLatestArticles,
        );

final Future<ArticleGroup> Function() getRecommendations =
    () async => await queryArticle(
          'getRecommendations',
          getRecommendedArticles,
        );
