import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'user_types.g.dart';
@HiveType(typeId: HiveTypesIds.userEnumTypeId)
enum UserType {
  @HiveField(0)
  caregiver,
  @HiveField(1)
  user,
  @HiveField(2, defaultValue: true)
  none,
}
