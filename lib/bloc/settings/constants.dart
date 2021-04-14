import 'models.dart';

// * All Pages ---
enum SettingsPageKey {
  Overview,
  General,
  Account,
}

// ? Overview Page ---
enum OverviewGroupKey {
  Common,
}

enum OverviewCommonKey {
  General,
  Account,
}

// ? General Page ---
enum GeneralGroupKey {
  Appearance,
  System,
}

enum GeneralAppearanceItemKey {
  Adaptive,
  Test,
}

enum GeneralSystemItemKey {
  Test,
}

// ? Account Page ---
enum AccountGroupKey {
  Profile,
  Connection,
}

enum AccountProfileItemKey {
  Name,
}

enum AccountConnectionItemKey {
  Email,
  Twitter,
}

const List<SettingReference> settingsToPersists = [
  SettingReference(
    page: SettingsPageKey.General,
    group: GeneralGroupKey.Appearance,
    setting: GeneralAppearanceItemKey.Adaptive,
  ),
  SettingReference(
    page: SettingsPageKey.General,
    group: GeneralGroupKey.System,
    setting: GeneralSystemItemKey.Test,
  ),
];

const settings = SettingsModel({
  SettingsPageKey.Overview: SettingPageDetail<OverviewGroupKey>(
    title: "Settings",
    groups: {
      OverviewGroupKey.Common: SettingGroup<OverviewCommonKey>(
        settings: {
          OverviewCommonKey.General: SettingItemNavigation(
            title: "General",
            value: SettingsPageKey.General,
          ),
          OverviewCommonKey.Account: SettingItemNavigation(
            title: "Account and Privacy",
            value: SettingsPageKey.Account,
          ),
        },
      ),
    },
  ),
  SettingsPageKey.General: SettingPageDetail<GeneralGroupKey>(
    title: "General",
    detail: "General Settings",
    groups: {
      GeneralGroupKey.Appearance: SettingGroup<GeneralAppearanceItemKey>(
        title: "Appearance",
        detail: "Detail",
        settings: {
          GeneralAppearanceItemKey.Adaptive: SettingItemBoolean(
            title: "Use Adaptive Theme",
            subtitle: "Follow device's theme",
            value: true,
          ),
        },
      ),
      GeneralGroupKey.System: SettingGroup<GeneralSystemItemKey>(
        title: "Extra Field",
        settings: {
          GeneralSystemItemKey.Test: SettingItemString(
            title: "Test String",
            value: "String",
          ),
        },
      ),
    },
  ),
  SettingsPageKey.Account: SettingPageDetail<AccountGroupKey>(
    title: "Account",
    groups: {
      AccountGroupKey.Profile: SettingGroup<AccountProfileItemKey>(
        settings: {
          AccountProfileItemKey.Name: SettingItemString(
            title: "Name",
            value: "saltyAom",
          ),
        },
      ),
      AccountGroupKey.Connection: SettingGroup<AccountConnectionItemKey>(
        settings: {
          AccountConnectionItemKey.Email: SettingItemString(
            title: "Mail",
            value: "me@saltyaom.com",
          ),
          AccountConnectionItemKey.Twitter: SettingItemString(
            title: "Twitter",
            value: "@saltyAom",
          ),
        },
      ),
    },
  ),
});
