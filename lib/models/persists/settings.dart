import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class PersistedSetting {
  @HiveField(0)
  dynamic value;

  PersistedSetting(this.value);
}
