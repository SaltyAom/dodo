import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/bloc.dart';

import 'package:dodo/layouts/drawer/drawer.dart';

import 'package:dodo/components/modules/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  final SettingsPageKey pageKey;

  const SettingsPage(
    this.pageKey, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDarkTheme = theme.brightness == Brightness.dark;

    final isRootPage = pageKey == SettingsPageKey.Overview;

    return DrawerLayout(
      enabled: isRootPage,
      child: BlocBuilder<SettingsBloc, SettingsModel>(
        builder: (context, settings) {
          final page = settings.pages[pageKey]!;
          final groupKeys = page.groups.keys.map((key) => key).toList();

          return Scaffold(
            backgroundColor: isDarkTheme
                ? theme.scaffoldBackgroundColor
                : Colors.grey.shade100,
            appBar: AppBar(
              title: Text(page.title),
              leading: isRootPage ? DrawerToggler() : null,
              backgroundColor: theme.scaffoldBackgroundColor,
            ),
            body: NikuColumn([
              if (page.detail != null)
                Text(
                  page.detail!,
                  style: textTheme.subtitle2,
                ).niku()
                  ..pl(16)
                  ..mt(16)
                  ..mb(4),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: page.groups.length,
                itemBuilder: (context, index) {
                  final groupKey = groupKeys[index];
                  final group = page.groups[groupKey]!;

                  final settingKeys =
                      group.settings.keys.map((key) => key).toList();

                  return Column(
                    key: ValueKey(page.title),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (group.title != null)
                        Text(group.title!).niku()
                          ..pl(16)
                          ..mb(4)
                          ..mb(group.detail == null ? 12 : 0),
                      if (group.detail != null)
                        Text(
                          group.detail!,
                          style: textTheme.subtitle2,
                        ).niku()
                          ..pl(16)
                          ..mb(12),
                      if (group.title != null || group.detail != null)
                        Divider(height: 0),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: group.settings.length,
                        separatorBuilder: (context, index) =>
                            Divider(height: 0),
                        itemBuilder: (context, index) {
                          final settingKey = settingKeys[index];
                          final setting = group.settings[settingKey]!;

                          final key = ValueKey(setting.title);

                          if (setting is SettingItemNavigation)
                            return SettingNavigation(
                              key: key,
                              setting: setting,
                              pageKey: setting.value,
                            );

                          if (setting is SettingItemBoolean)
                            return SettingSwitch(
                              key: key,
                              pageKey: pageKey,
                              setting: setting,
                              groupKey: groupKey,
                              settingKey: settingKey,
                            );

                          if (setting is SettingItemString)
                            return SettingTextField(
                              key: key,
                              pageKey: pageKey,
                              setting: setting,
                              groupKey: groupKey,
                              settingKey: settingKey,
                            );

                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ).niku()
                    ..pt(group.title != null || group.detail != null ? 16 : 0)
                    ..bg(
                      isDarkTheme
                          ? Colors.black.withOpacity(.2)
                          : theme.scaffoldBackgroundColor,
                    )
                    ..my(8);
                },
              ),
            ]).crossStart().niku()
              ..pb(16)
              ..scrollable(),
          );
        },
      ),
    );
  }
}
