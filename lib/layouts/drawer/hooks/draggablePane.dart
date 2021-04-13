import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/drawer/drawer.dart';

const _close = 0.0;
const _open = 280.0;
const _intent = 80.0;

class DraggablePane {
  final AnimationController dragController;
  final Widget Function(Widget) draggable;
  final double Function(double) getProgress;

  const DraggablePane({
    required this.dragController,
    required this.draggable,
    required this.getProgress,
  });
}

final getProgress = (double value) => value / _open;

DraggablePane useDraggablePane(BuildContext context) {
  // ? Position
  final start = useState(0.0);
  final end = useState(0.0);

  // ? Get initial drawer position to spring back if not intent.
  final drawerStart = useState(0.0);

  final dragController = useAnimationController(
    initialValue: 0.0,
    lowerBound: _close,
    upperBound: _open,
  );

  final drawerBloc = context.read<DrawerBloc>();

  useEffect(() {
    final drawerController = drawerBloc.stream.listen((event) {
      dragController.animateTo(
        event.isOpen ? _open : _close,
        duration: drawerDuration,
        curve: Curves.easeOutExpo,
      );
    });

    return () {
      drawerController.cancel();
    };
  }, [drawerBloc, dragController]);

  final draggable = (Widget child) => Niku(child)
    ..on(
      horizontalDragStart: (detail) {
        start.value = detail.localPosition.dx;

        drawerStart.value = dragController.value.toDouble();
      },
      horizontalDragUpdate: (detail) {
        final moved = start.value - detail.localPosition.dx;
        final from = drawerStart.value < _open ? drawerStart.value : _open;

        final drawer = from - moved;

        end.value = detail.localPosition.dx;

        final inRange = drawer >= _close && drawer <= _open;

        if (inRange) dragController.value = drawer;
      },
      horizontalDragEnd: (detail) {
        final noIntentToCallDrawer = (start.value - end.value).abs() < _intent;
        final drawToClose = end.value < start.value;

        if (noIntentToCallDrawer)
          drawerBloc.add(
            drawerStart.value == _close ? DrawerClose() : DrawerOpen(),
          );
        else
          drawerBloc.add(
            drawToClose ? DrawerClose() : DrawerOpen(),
          );
      },
    );

  return DraggablePane(
    dragController: dragController,
    draggable: draggable,
    getProgress: getProgress,
  );
}
