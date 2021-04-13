import 'package:flutter/material.dart';

class SettingThemeData extends StatelessWidget {
  final Widget child;

  const SettingThemeData({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: child,
    );
  }
}

final withSettingThemeData = (Widget child) => SettingThemeData(child: child);
