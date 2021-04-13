import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/settings/settings.dart';
import 'package:dodo/bloc/navigator/navigator.dart';

import '../settings.dart';

class SettingTextField extends StatelessWidget {
  final SettingItemString setting;

  final SettingsPageKey pageKey;
  final groupKey;
  final settingKey;

  const SettingTextField({
    Key? key,
    required this.setting,
    required this.pageKey,
    required this.groupKey,
    required this.settingKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorBloc = context.read<NavigatorBloc>();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListTile(
      title: SettingItemTitle(setting.title),
      subtitle: SettingItemSubtitle(setting.subtitle),
      trailing: Text(setting.value, style: textTheme.subtitle2),
      onTap: () async {
        final page = await createSettingsTextField(
          setting: setting,
          pageKey: pageKey,
          groupKey: groupKey,
          settingKey: settingKey,
        );

        navigatorBloc.add(
          NavigatorAppendPage(page),
        );
      },
    ).niku()
      ..builder(withSettingThemeData);
  }
}
