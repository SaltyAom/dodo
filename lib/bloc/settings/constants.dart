import 'models.dart';

// ---
enum SettingsPageKey {
  Overview,
  General,
  Account,
}
// ---

// ---
enum OverviewGroupKey {
  Common,
}

enum OverviewCommonKey {
  General,
  Account,
}
// ---

// ---
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
// ---

// ---
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
// ---

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
            subtitle: "Follow theme device's theme mode setting",
            value: false,
          ),
          GeneralAppearanceItemKey.Test: SettingItemBoolean(
            title: "Test",
            value: false,
          ),
        },
      ),
      GeneralGroupKey.System: SettingGroup<GeneralSystemItemKey>(
        title: "Test",
        settings: {
          GeneralSystemItemKey.Test: SettingItemBoolean(
            title: "Test",
            value: false,
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
