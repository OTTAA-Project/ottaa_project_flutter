import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'devices_accessibility.g.dart';

@HiveType(typeId: HiveTypesIds.devicesAccessibilityEnumTypeId)
enum DevicesAccessibility {
  @HiveField(0)
  none,

  @HiveField(1)
  press,

  @HiveField(2)
  scroll,

  @HiveField(3)
  sipuff
}
