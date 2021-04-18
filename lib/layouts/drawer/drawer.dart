import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/drawer/drawer.dart';

import 'components/components.dart';

import 'hooks/hooks.dart';

import 'styles.dart';

export 'components/drawerToggler.dart';

class DrawerLayout extends HookWidget {
  final Widget child;
  final bool enabled;

  const DrawerLayout({
    Key? key,
    required this.child,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final draggablePane = useDraggablePane(context);

    if (!enabled) return child;

    final draggable = draggablePane.draggable;

    final theme = Theme.of(context);
    final screen = MediaQuery.of(context);

    return NikuStack([
      DrawerMenuList().niku()..builder(draggable),
      Niku()
        ..bg(theme.scaffoldBackgroundColor)
        ..fullSize()
        ..builder(
          pageTransformEffect(
            draggablePane,
            scale: .95,
            offset: 20,
            rotationDegree: 1.25,
            colorIntense: .025,
          ),
        ),
      child.niku()
        ..builder(
          pageTransformEffect(
            draggablePane,
            rotationDegree: 5,
          ),
        ),
      Niku()
        ..widthPercent(8.75)
        ..height(screen.size.height - screen.padding.top - 96)
        ..bg(Colors.transparent)
        ..bottomLeft()
        ..builder(draggable)
        ..builder(
          (child) => BlocBuilder<DrawerBloc, DrawerModel>(
            builder: (context, drawer) {
              return Niku(child)..ignorePointer(drawer.isOpen);
            },
          ),
        ),
    ]);
  }
}
