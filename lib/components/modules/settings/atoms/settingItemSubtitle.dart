import 'package:flutter/material.dart';

class _SettingItemSubtitle extends StatelessWidget {
  final String? subtitle;

  const _SettingItemSubtitle(
    this.subtitle, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return subtitle != null
        ? Text(
            subtitle!,
            style: textTheme.subtitle2,
          )
        : SizedBox.shrink();
  }
}

// ignore: non_constant_identifier_names
final _SettingItemSubtitle? Function(String? subtitle) SettingItemSubtitle =
    (String? subtitle) =>
        subtitle != null ? _SettingItemSubtitle(subtitle) : null;
