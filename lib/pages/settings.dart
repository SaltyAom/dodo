import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:niku/niku.dart';

import 'package:dodo/layouts/drawer/drawer.dart';

class SettingsData {
  final String title;
  final String? subtitle;

  const SettingsData({
    required this.title,
    this.subtitle,
  });
}

const _settings = const [
  SettingsData(
    title: "Test",
  ),
  SettingsData(
    title: "Use Adaptive Theme",
    subtitle: "Follow theme mode based on device's settings",
  )
];

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return DrawerLayout(
      Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          leading: DrawerToggler(),
        ),
        body: NikuColumn([
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _settings.length,
            separatorBuilder: (context, index) => Divider(height: 0),
            itemBuilder: (context, index) {
              final setting = _settings[index];

              return Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: SwitchListTile.adaptive(
                  title: Text(
                    setting.title,
                    style: textTheme.bodyText1,
                  ),
                  subtitle: setting.subtitle != null
                      ? Text(
                          setting.subtitle!,
                          style: textTheme.subtitle2,
                        )
                      : null,
                  value: true,
                  dense: true,
                  onChanged: (a) {},
                ),
              );
            },
          ),
        ]).niku()
          ..scrollable(),
      ),
    );
  }
}
