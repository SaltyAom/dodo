import 'package:flutter/material.dart';

import 'package:dodo/pages/pages.dart';
import 'package:dodo/pages/landing.dart';

import 'package:dodo/bloc/bloc.dart';

import 'transitions.dart';

final createLandingPage = () async => Future.microtask(
      () => MaterialPage(
        key: ValueKey("/"),
        name: "/",
        child: Landing(),
      ),
    );

final createArticlePage = (ArticleMetadata article) async => Future.microtask(
      () => MaterialPage(
        key: ValueKey("/article/${article.title}"),
        name: "/article/${article.title}",
        child: ArticlePage(article),
      ),
    );

final createSettingsPage = () async => Future.microtask(
      () => MaterialPage(
        key: ValueKey("/settings"),
        name: "/settings",
        child: SettingsPage(),
      ),
    );

final createLandingPageUsingFade = () async => Future.microtask(
      () => UsingFadeTransition(
        Landing(),
        key: ValueKey("/"),
      ),
    );

final createSettingsPageUsingFade = () async => Future.microtask(
      () => UsingFadeTransition(
        SettingsPage(),
        key: ValueKey("/settings"),
      ),
    );
