import 'package:equatable/equatable.dart';

import 'models.dart';
import 'actions/actions.dart';

abstract class ArticleEvent extends Equatable {}

class ArticleOverride extends ArticleEvent {
  final ArticleModel model;

  ArticleOverride(this.model);

  @override
  get props => [
        [model.trendings, model.latests, model.recommendations].map(
          (articleType) =>
              articleType.articles?.map(
                (article) => article.title,
              ) ??
              "",
        ),
      ];
}

class ArticleFetchHeadline extends ArticleEvent {
  final ArticleHeadlineType headline;
  final bool toOverride;

  ArticleFetchHeadline({
    this.headline = ArticleHeadlineType.All,
    this.toOverride = false,
  });

  ArticleModel setLoading(ArticleModel model) {
    if (headline == ArticleHeadlineType.All) return ArticleModel();

    return ArticleModel(
      trendings: headline == ArticleHeadlineType.Trending
          ? defaultArticleValue
          : model.trendings,
      recommendations: headline == ArticleHeadlineType.Recommended
          ? defaultArticleValue
          : model.recommendations,
      latests: headline == ArticleHeadlineType.Latest
          ? defaultArticleValue
          : model.latests,
    );
  }

  Future<ArticleModel> fetch(ArticleModel model) async {
    await Future.delayed(
      Duration(milliseconds: 500),
    );

    switch (headline) {
      case ArticleHeadlineType.Trending:
        final trendings = await getTrendings();

        if (toOverride)
          return ArticleModel(
            trendings: trendings,
            latests: model.latests,
            recommendations: model.recommendations,
          );

        return ArticleModel(
          trendings:
              model.trendings.isLoaded ? model.trendings : await getTrendings(),
          latests: model.latests,
          recommendations: model.recommendations,
        );

      case ArticleHeadlineType.Latest:
        final latests = await getLatests();

        if (toOverride)
          return ArticleModel(
            trendings: model.trendings,
            latests: latests,
            recommendations: model.recommendations,
          );

        return ArticleModel(
          trendings: model.trendings,
          latests: model.latests.isLoaded ? model.latests : latests,
          recommendations: model.recommendations,
        );

      case ArticleHeadlineType.Recommended:
        final recommendations = await getRecommendations();

        if (toOverride)
          return ArticleModel(
            trendings: model.trendings,
            latests: model.latests,
            recommendations: recommendations,
          );

        return ArticleModel(
          trendings: model.trendings,
          latests: model.latests,
          recommendations: model.recommendations.isLoaded
              ? model.recommendations
              : recommendations,
        );

      case ArticleHeadlineType.All:
        final trendings = await getTrendings();
        final latests = await getLatests();
        final recommendations = await getRecommendations();

        return Future.microtask(() {
          if (toOverride)
            return ArticleModel(
              trendings: trendings,
              latests: latests,
              recommendations: recommendations,
            );

          return ArticleModel(
            trendings: model.trendings.isLoaded ? model.trendings : trendings,
            latests: model.latests.isLoaded ? model.latests : latests,
            recommendations: model.recommendations.isLoaded
                ? model.recommendations
                : recommendations,
          );
        });
    }
  }

  @override
  get props => [headline, toOverride];
}
