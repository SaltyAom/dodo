import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'constants.dart';

abstract class SettingsEvent extends Equatable {}

@immutable
class SettingBooleanUpdate extends SettingsEvent {
  final SettingsPageKey page;
  final group;
  final setting;

  final bool newValue;

  SettingBooleanUpdate({
    required this.page,
    required this.group,
    required this.setting,
    required this.newValue,
  });

  @override
  get props => [page, group, setting];
}

@immutable
class SettingStringUpdate extends SettingsEvent {
  final SettingsPageKey page;
  final group;
  final setting;

  final String newValue;

  SettingStringUpdate({
    required this.page,
    required this.group,
    required this.setting,
    required this.newValue,
  });

  @override
  get props => [page, group, setting];
}
