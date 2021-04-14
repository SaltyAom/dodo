import "package:flutter_bloc/flutter_bloc.dart";

import 'package:hive/hive.dart';

import 'package:dodo/models/persists/settings.dart';

import 'models.dart';
import 'events.dart';
import 'constants.dart';

export 'models.dart';
export 'events.dart';
export 'constants.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsModel> {
  SettingsBloc() : super(settings);

  @override
  mapEventToState(event) async* {
    if (event is SettingBooleanUpdate) {
      final reference = event.reference;

      final page = state.pages[reference.page]!;
      final group = page.groups[reference.group]!;
      final setting = group.settings[reference.setting]!;

      yield SettingsModel({
        ...state.pages,
        reference.page: SettingPageDetail(
          title: page.title,
          detail: page.detail,
          groups: {
            ...page.groups,
            reference.group: SettingGroup(
              title: group.title,
              detail: group.detail,
              settings: {
                ...group.settings,
                reference.setting: SettingItemBoolean(
                  title: setting.title,
                  subtitle: setting.subtitle,
                  value: event.newValue,
                ),
              },
            ),
          },
        ),
      });

      if (event.shouldPersists && settingsToPersists.contains(reference)) {
        final settings = await Hive.openBox<PersistedSetting>("settings");

        settings.put(
          reference.key,
          PersistedSetting(event.newValue),
        );
      }
    } else if (event is SettingStringUpdate) {
      final reference = event.reference;

      final page = state.pages[reference.page]!;
      final group = page.groups[reference.group]!;
      final setting = group.settings[reference.setting]!;

      yield SettingsModel({
        ...state.pages,
        reference.page: SettingPageDetail(
          title: page.title,
          detail: page.detail,
          groups: {
            ...page.groups,
            reference.group: SettingGroup(
              title: group.title,
              detail: group.detail,
              settings: {
                ...group.settings,
                reference.setting: SettingItemString(
                  title: setting.title,
                  subtitle: setting.subtitle,
                  value: event.newValue,
                ),
              },
            ),
          },
        ),
      });

      if (event.shouldPersists && settingsToPersists.contains(reference)) {
        final settings = await Hive.openBox<PersistedSetting>("settings");

        settings.put(
          reference.key,
          PersistedSetting(event.newValue),
        );
      }
    }
  }
}
