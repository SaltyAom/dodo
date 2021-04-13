import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

export 'actions/actions.dart';

@immutable
abstract class NavigatorEvent extends Equatable {}

@immutable
class NavigatorAppendPage extends NavigatorEvent {
  final Page<dynamic> page;

  NavigatorAppendPage(this.page);

  @override
  get props => [page.name];
}

@immutable
class NavigatorPopPage extends NavigatorEvent {
  @override
  get props => [];
}

@immutable
class NavigatorOverridePage extends NavigatorEvent {
  final List<Page<dynamic>> pages;

  NavigatorOverridePage(this.pages);

  @override
  get props => [...pages.map((page) => page.name)];
}

@immutable
class NavigatorSetRootPage extends NavigatorEvent {
  final Page<dynamic> page;

  NavigatorSetRootPage(this.page);

  @override
  get props => [page.name];
}
