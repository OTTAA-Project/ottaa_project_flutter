import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'display_types.g.dart';

@HiveType(typeId: HiveTypesIds.displayTypeEnumTypeId)
enum DisplayTypes {
  @HiveField(0)
  grid,

  @HiveField(1)
  tab,
}
