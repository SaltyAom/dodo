import 'package:flutter/material.dart';

class SettingItemTitle extends StatelessWidget {
  final String title;

  const SettingItemTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      title,
      style: textTheme.bodyText1,
    );
  }
}
