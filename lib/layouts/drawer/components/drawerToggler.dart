import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:niku/niku.dart';

import 'package:dodo/bloc/drawer/drawer.dart';

class DrawerToggler extends StatelessWidget {
  const DrawerToggler({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerBloc = context.read<DrawerBloc>();

    return NikuIconButton(
      Icon(Icons.menu),
    )
      ..onPressed(() {
        drawerBloc.add(DrawerToggle());
      })
      ..splashRadius(28);
  }
}
