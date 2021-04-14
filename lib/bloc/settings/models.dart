import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'constants.dart';

@immutable
class SettingReference extends Equatable {
  final SettingsPageKey page;
  final group;
  final setting;

  const SettingReference({
    required this.page,
    required this.group,
    required this.setting,
  });

  String get key => "$page-$group-$setting";

  @override
  get props => [key];
}

@immutable
class SettingItem extends Equatable {
  final String title;
  final String? subtitle;
  final dynamic value;

  const SettingItem({
    required this.title,
    this.subtitle,
    required this.value,
  });

  @override
  get props => [title];
}

@immutable
class SettingItemBoolean extends SettingItem {
  const SettingItemBoolean({
    required String title,
    String? subtitle,
    required bool value,
  }) : super(title: title, subtitle: subtitle, value: value);

  @override
  get props => [title];
}

@immutable
class SettingItemString extends SettingItem {
  const SettingItemString({
    required String title,
    String? subtitle,
    required String value,
  }) : super(title: title, subtitle: subtitle, value: value);

  @override
  get props => [title];
}

@immutable
class SettingItemNavigation extends SettingItem {
  const SettingItemNavigation({
    required String title,
    String? subtitle,
    required SettingsPageKey value,
  }) : super(title: title, subtitle: subtitle, value: value);

  @override
  get props => [title];
}

@immutable
class SettingGroup<T> {
  final String? title;
  final String? detail;
  final Map<T, SettingItem> settings;

  const SettingGroup({
    this.title,
    this.detail,
    required this.settings,
  });
}

@immutable
class SettingPageDetail<T> {
  final String title;
  final String? detail;
  final Map<T, SettingGroup> groups;

  const SettingPageDetail({
    required this.title,
    this.detail,
    required this.groups,
  });
}

@immutable
class SettingsModel {
  final Map<SettingsPageKey, SettingPageDetail> pages;

  const SettingsModel(this.pages);
}
