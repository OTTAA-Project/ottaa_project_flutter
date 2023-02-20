import 'package:hive_flutter/hive_flutter.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'size_types.g.dart';

@HiveType(typeId: HiveTypesIds.sizeTypeEnumTypeId)
enum SizeTypes {
  @HiveField(0)
  small,
  @HiveField(1)
  mid,
  @HiveField(2)
  big,
}