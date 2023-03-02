import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'sweep_modes.g.dart';

@HiveType(typeId: HiveTypesIds.sweepModesEnumTypeId)
enum SweepModes {
  @HiveField(0)
  elements,

  @HiveField(1)
  sweep,
}
