import 'package:hive_flutter/hive_flutter.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'velocity_types.g.dart';

@HiveType(typeId: HiveTypesIds.velocityTypeEnumTypeId)
enum VelocityTypes {
  @HiveField(0)
  slow,

  @HiveField(1)
  mid,

  @HiveField(2)
  fast,
}
