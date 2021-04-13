import 'package:flutter/material.dart';

import 'package:dodo/pages/pages.dart';

@immutable
class NavigatorModel {
  final List<Page> pages;

  NavigatorModel({
    this.pages = const [
      MaterialPage(
        child: Landing(),
      )
    ],
  });
}
