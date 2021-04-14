import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/settings/settings.dart';

import '../settings.dart';

class SettingSwitch extends StatelessWidget {
  final SettingItemBoolean setting;

  final SettingsPageKey pageKey;
  final groupKey;
  final settingKey;

  const SettingSwitch({
    Key? key,
    required this.setting,
    required this.pageKey,
    required this.groupKey,
    required this.settingKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingsBloc>();

    return SwitchListTile.adaptive(
      title: SettingItemTitle(setting.title),
      subtitle: SettingItemSubtitle(setting.subtitle),
      value: setting.value,
      onChanged: (value) {
        settingBloc.add(
          SettingBooleanUpdate(
            reference: SettingReference(
              page: pageKey,
              group: groupKey,
              setting: settingKey,
            ),
            newValue: value,
          ),
        );
      },
    ).niku()
      ..builder(withSettingThemeData);
  }
}
