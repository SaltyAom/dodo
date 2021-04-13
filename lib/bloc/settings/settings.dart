import "package:flutter_bloc/flutter_bloc.dart";

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
      final page = state.pages[event.page]!;
      final group = page.groups[event.group]!;
      final setting = group.settings[event.setting]!;

      yield SettingsModel({
        ...state.pages,
        event.page: SettingPageDetail(
          title: page.title,
          detail: page.detail,
          groups: {
            ...page.groups,
            event.group: SettingGroup(
              title: group.title,
              detail: group.detail,
              settings: {
                ...group.settings,
                event.setting: SettingItemBoolean(
                  title: setting.title,
                  subtitle: setting.subtitle,
                  value: event.newValue,
                ),
              },
            ),
          },
        ),
      });
    } else if (event is SettingStringUpdate) {
      final page = state.pages[event.page]!;
      final group = page.groups[event.group]!;
      final setting = group.settings[event.setting]!;

      yield SettingsModel({
        ...state.pages,
        event.page: SettingPageDetail(
          title: page.title,
          detail: page.detail,
          groups: {
            ...page.groups,
            event.group: SettingGroup(
              title: group.title,
              detail: group.detail,
              settings: {
                ...group.settings,
                event.setting: SettingItemString(
                  title: setting.title,
                  subtitle: setting.subtitle,
                  value: event.newValue,
                ),
              },
            ),
          },
        ),
      });
    }
  }
}
