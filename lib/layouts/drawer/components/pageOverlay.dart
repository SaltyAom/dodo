import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/drawer/drawer.dart';

class DrawerPageOverlay extends StatelessWidget {
  final Widget child;

  const DrawerPageOverlay(
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerBloc = context.read<DrawerBloc>();

    return BlocBuilder<DrawerBloc, DrawerModel>(builder: (context, drawer) {
      return Niku(child)
        ..absorbPointer(drawer.isOpen)
        ..on(tap: () {
          if (!drawer.isOpen) return;

          drawerBloc.add(
            DrawerClose(),
          );
        });
    });
  }
}

final drawerPageOverlay = (Widget child) => DrawerPageOverlay(child);
