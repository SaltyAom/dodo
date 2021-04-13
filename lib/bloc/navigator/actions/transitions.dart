import 'package:flutter/material.dart';

import 'package:dodo/bloc/drawer/drawer.dart';

class UsingFadeTransition extends Page {
  final Widget child;

  const UsingFadeTransition(
    this.child, {
    required LocalKey key,
  }) : super(key: key);

  @override
  Route createRoute(context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: drawerDuration * .75,
      pageBuilder: (context, animation, setAnimation) {
        return FadeTransition(
          child: child,
          opacity: animation,
        );
      },
    );
  }
}
