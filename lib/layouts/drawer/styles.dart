import 'package:flutter/material.dart';

import 'dart:math' as Math;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/drawer/drawer.dart';

import 'package:dodo/layouts/drawer/hooks/draggablePane.dart';

import 'components/components.dart';

typedef PageTransformEffect = Niku Function(Widget) Function(
  BuildContext,
  DraggablePane, {
  double offset,
  double rotationDegree,
  double scale,
  double shadowOpacity,
  double colorIntense,
});

class _PageTransformEffect extends StatelessWidget {
  final Widget child;
  final DraggablePane draggablePane;
  final double shadowOpacity;
  final double scale;
  final double offset;
  final double rotationDegree;
  final double colorIntense;

  const _PageTransformEffect(
    this.child,
    this.draggablePane, {
    this.shadowOpacity = .125,
    this.scale = 1,
    this.offset = 0,
    this.rotationDegree = 0,
    this.colorIntense = .0875,
  });

  @override
  Widget build(BuildContext context) {
    final draggable = draggablePane.draggable;
    final dragController = draggablePane.dragController;
    final getProgress = draggablePane.getProgress;

    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    final overlay = (Widget child) =>
        child.niku()..builder(drawerPageOverlay)..builder(draggable);

    return child.niku()
      ..animated(
        dragController,
        (context, child) {
          final value = dragController.value;
          final progress = getProgress(value);

          final scaling = 1 - progress * .2;

          return child.niku()
            ..builder((child) {
              return NikuStack([
                child,
                Niku()
                  ..fullSize()
                  ..bg(
                    isDarkTheme
                        ? Colors.white.withOpacity(progress * colorIntense)
                        : Colors.black
                            .withOpacity(progress * colorIntense * .2),
                  )
                  ..builder(
                    (child) => BlocBuilder<DrawerBloc, DrawerModel>(
                      builder: (context, drawer) {
                        return Niku(child)..ignorePointer(!drawer.isOpen);
                      },
                    ),
                  ),
              ]);
            })
            ..rounded(16 + progress * 8)
            ..shadows([
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, progress * shadowOpacity),
                offset: Offset(0, progress * 24),
                spreadRadius: progress * 6,
                blurRadius: progress * 52,
              ),
            ])
            ..builder(overlay)
            ..transform(Matrix4.identity()..leftTranslate(value))
            ..builder(
              (child) => Transform.scale(
                child: child,
                scale: scaling * scale,
                alignment: Alignment.centerLeft,
              ),
            )
            ..builder(
              (child) => Transform.translate(
                child: child,
                offset: Offset(0, progress * offset),
              ),
            )
            ..builder(
              (child) => rotationDegree == 0
                  ? child
                  : Transform.rotate(
                      child: child,
                      angle: progress * (Math.pi / 180 * rotationDegree),
                    ),
            );
        },
      );
  }
}

final pageTransformEffect = (
  DraggablePane draggablePane, {
  double shadowOpacity = .125,
  double scale = 1,
  double offset = 0,
  double rotationDegree = 0,
  double colorIntense = .0875,
}) =>
    (Widget child) => _PageTransformEffect(
          child,
          draggablePane,
          shadowOpacity: shadowOpacity,
          scale: scale,
          offset: offset,
          rotationDegree: rotationDegree,
          colorIntense: colorIntense,
        );
