import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'models.dart';

abstract class SettingsEvent extends Equatable {}

@immutable
class SettingBooleanUpdate extends SettingsEvent {
  final SettingReference reference;
  final bool shouldPersists;

  final bool newValue;

  SettingBooleanUpdate({
    required this.reference,
    required this.newValue,
    this.shouldPersists = true,
  });

  @override
  get props => [reference.page, reference.group, reference.setting, newValue];
}

@immutable
class SettingStringUpdate extends SettingsEvent {
  final SettingReference reference;
  final bool shouldPersists;

  final String newValue;

  SettingStringUpdate({
    required this.reference,
    required this.newValue,
    this.shouldPersists = true,
  });

  @override
  get props => [reference.page, reference.group, reference.setting, newValue];
}
