import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/bloc.dart';

class _NavigationMenu {
  final String title;
  final Future<dynamic> Function() createPage;
  final IconData icon;

  const _NavigationMenu(
    this.title,
    this.icon,
    this.createPage,
  );
}

final _navigationList = [
  _NavigationMenu(
    "Landing",
    Icons.article_outlined,
    createLandingPageUsingFade,
  ),
  _NavigationMenu(
    "Settings",
    Icons.settings_outlined,
    createSettingsPageUsingFade,
  ),
];

final _pageTransitionDelay = Duration(
  milliseconds: (drawerDuration.inMilliseconds * .5).toInt(),
);

class DrawerMenuList extends StatelessWidget {
  const DrawerMenuList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = context.read<NavigatorBloc>();
    final drawerBloc = context.read<DrawerBloc>();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: NikuColumn(
        _navigationList
            .map(
              (navigation) => NikuButton.icon(
                Icon(
                  navigation.icon,
                  size: 21,
                  color: textTheme.headline6!.color,
                ),
              )
                ..label(
                  Text(navigation.title),
                )
                ..onPressed(() async {
                  drawerBloc.add(DrawerClose());

                  await Future.delayed(_pageTransitionDelay);

                  navigationBloc.add(
                    NavigatorSetRootPage(
                      await navigation.createPage(),
                    ),
                  );
                })
                ..rounded(0)
                ..centerLeft()
                ..p(16)
                ..px(24),
            )
            .toList(),
      ).stretch().niku()
        ..width(280),
    );
  }
}
