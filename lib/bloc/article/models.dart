import 'package:flutter/material.dart';

export 'package:dodo/models/models.dart';

enum ArticleHeadlineType {
  Trending,
  Latest,
  Recommended,
  All,
}

const headlineTypeOrder = [
  ArticleHeadlineType.Trending,
  ArticleHeadlineType.Latest,
  ArticleHeadlineType.Recommended,
];

const Map<ArticleHeadlineType, String> articleHeadline = {
  ArticleHeadlineType.Trending: "Trending",
  ArticleHeadlineType.Latest: "Latest",
  ArticleHeadlineType.Recommended: "Recommended",
};

@immutable
class ArticleGroup {
  final bool isLoaded;
  final bool error;
  final String? errorMessage;
  final List<ArticleMetadata>? articles;

  const ArticleGroup({
    this.isLoaded = false,
    this.error = false,
    this.errorMessage,
    this.articles,
  })  : assert(!error && errorMessage == null),
        assert(!isLoaded || (isLoaded && articles != null));
}

const defaultArticleValue = const ArticleGroup();

@immutable
class ArticleModel {
  final ArticleGroup trendings;
  final ArticleGroup latests;
  final ArticleGroup recommendations;

  const ArticleModel({
    this.trendings = defaultArticleValue,
    this.latests = defaultArticleValue,
    this.recommendations = defaultArticleValue,
  });
}

@immutable
class ArticleMetadata {
  final String title;
  final String date;
  final String author;
  final String image;

  const ArticleMetadata({
    required this.title,
    required this.date,
    required this.author,
    required this.image,
  });
}
