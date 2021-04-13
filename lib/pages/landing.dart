import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/article/article.dart';

import 'package:dodo/layouts/drawer/drawer.dart';

import 'package:dodo/components/organisms/organisms.dart';

class Landing extends HookWidget {
  const Landing();

  @override
  Widget build(BuildContext context) {
    final articleBloc = context.read<ArticleBloc>();

    final tabBarController = useTabController(
      initialLength: headlineTypeOrder.length,
    );

    useEffect(() {
      final headline = headlineTypeOrder[0];

      articleBloc.add(
        ArticleFetchHeadline(headline: headline),
      );

      tabBarController.addListener(() {
        final headline = headlineTypeOrder[tabBarController.index];

        articleBloc.add(
          ArticleFetchHeadline(headline: headline),
        );
      });
    }, []);

    return DrawerLayout(
      Scaffold(
        appBar: AppBar(
          title: Text("Dodo"),
          leading: DrawerToggler(),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: TabBar(
              controller: tabBarController,
              isScrollable: true,
              tabs: headlineTypeOrder
                  .map(
                    (headline) => Tab(
                      child: Text(articleHeadline[headline]!),
                    ),
                  )
                  .toList(),
            ).niku()
              ..pl(16)
              ..centerLeft(),
          ),
        ),
        body: BlocBuilder<ArticleBloc, ArticleModel>(
          builder: (context, model) => TabBarView(
            controller: tabBarController,
            children: [
              ArticleOverview(
                headline: ArticleHeadlineType.Trending,
                articleGroup: model.trendings,
              ),
              ArticleOverview(
                headline: ArticleHeadlineType.Latest,
                articleGroup: model.latests,
              ),
              ArticleOverview(
                headline: ArticleHeadlineType.Recommended,
                articleGroup: model.recommendations,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
