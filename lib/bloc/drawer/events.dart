import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'package:dodo/bloc/drawer/drawer.dart';

abstract class DrawerEvent extends Equatable {}

@immutable
class DrawerOpen extends DrawerEvent {
  final _model = DrawerModel(isOpen: true);
  DrawerModel get model => _model;

  @override
  get props => [true];
}

@immutable
class DrawerClose extends DrawerEvent {
  final _model = DrawerModel(isOpen: false);
  DrawerModel get model => _model;

  @override
  get props => [false];
}

@immutable
class DrawerToggle extends DrawerEvent {
  @override
  get props => ["toggle"];
}
