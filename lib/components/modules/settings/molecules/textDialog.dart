import 'package:dodo/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dodo/bloc/settings/settings.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/settings/settings.dart';

class SettingTextFieldDialog extends HookWidget {
  final SettingItemString setting;

  final SettingsPageKey pageKey;
  final groupKey;
  final settingKey;

  const SettingTextFieldDialog({
    Key? key,
    required this.setting,
    required this.pageKey,
    required this.groupKey,
    required this.settingKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: setting.value);

    final settingBloc = context.read<SettingsBloc>();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final isDarkTheme = theme.brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        settingBloc.add(
          SettingStringUpdate(
            reference: SettingReference(
              page: pageKey,
              group: groupKey,
              setting: settingKey,
            ),
            newValue: controller.text,
          ),
        );

        return true;
      },
      child: Scaffold(
        backgroundColor:
            isDarkTheme ? theme.scaffoldBackgroundColor : Colors.grey.shade100,
        appBar: AppBar(
          title: Text(setting.title),
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [
            NikuButton(
              Text("Reset"),
            )
              ..fontSize(16)
              ..w500()
              ..px(16)
              ..onPressed(
                () {
                  controller.text = setting.value;
                  controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller.text.length),
                  );
                },
              ),
          ],
        ),
        body: NikuTextField(setting.title)
            .controller(controller)
            .border(InputBorder.none)
            .autofocus(true)
            .contentPadding(
              EdgeInsets.symmetric(vertical: 16),
            )
            .suffix(
              Icon(
                Icons.highlight_off_rounded,
                color: textTheme.subtitle2?.color,
              ).niku().on(tap: () {
                controller.text = "";
              }),
            )
            .niku()
              ..px(16)
              ..bg(
                isDarkTheme
                    ? Colors.black.withOpacity(.2)
                    : theme.scaffoldBackgroundColor,
              )
              ..mt(8),
      ),
    );
  }
}
