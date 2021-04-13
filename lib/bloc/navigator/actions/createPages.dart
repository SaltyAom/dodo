import 'package:flutter/material.dart';

import 'package:dodo/pages/pages.dart';
import 'package:dodo/pages/landing.dart';

import 'package:dodo/bloc/bloc.dart';

import 'transitions.dart';

import 'package:dodo/components/modules/settings/molecules/textDialog.dart';

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

final createSettingsPage = ([
  SettingsPageKey pageKey = SettingsPageKey.Overview,
]) async =>
    Future.microtask(
      () => MaterialPage(
        key: ValueKey(pageKey),
        name: "/settings",
        child: SettingsPage(pageKey),
      ),
    );

final createLandingPageUsingFade = () async => Future.microtask(
      () => UsingFadeTransition(
        Landing(),
        key: ValueKey("/"),
      ),
    );

final createSettingsPageUsingFade = ([
  SettingsPageKey pageKey = SettingsPageKey.Overview,
]) async =>
    Future.microtask(
      () => UsingFadeTransition(
        SettingsPage(pageKey),
        key: ValueKey(pageKey),
      ),
    );

final createSettingsTextField = ({
  required SettingItemString setting,
  required SettingsPageKey pageKey,
  required groupKey,
  required settingKey,
}) async =>
    Future.microtask(
      () => MaterialPage(
        key: ValueKey("/setting/${setting.title}"),
        name: "/article/${setting.title}",
        child: SettingTextFieldDialog(
          setting: setting,
          pageKey: pageKey,
          groupKey: groupKey,
          settingKey: settingKey,
        ),
      ),
    );
