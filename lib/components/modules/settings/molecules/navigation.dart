import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/settings/settings.dart';
import 'package:dodo/bloc/navigator/navigator.dart';

import '../settings.dart';

class SettingNavigation extends StatelessWidget {
  final SettingItemNavigation setting;

  final SettingsPageKey pageKey;

  const SettingNavigation({
    Key? key,
    required this.setting,
    required this.pageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorBloc = context.read<NavigatorBloc>();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListTile(
      title: SettingItemTitle(setting.title),
      subtitle: SettingItemSubtitle(setting.subtitle),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: textTheme.subtitle2!.color,
      ),
      onTap: () async {
        final page = await createSettingsPage(pageKey);

        navigatorBloc.add(
          NavigatorAppendPage(page),
        );
      },
    ).niku()
      ..builder(withSettingThemeData);
  }
}
