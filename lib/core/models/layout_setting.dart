import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/enums/display_types.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';

part 'layout_setting.g.dart';

@HiveType(typeId: HiveTypesIds.layoutTypeId)
class LayoutSetting {
  @HiveField(0, defaultValue: false)
  bool cleanup;

  @HiveField(1)
  ShortcutsModel shortcuts;

  @HiveField(2, defaultValue: DisplayTypes.grid)
  DisplayTypes display;
  @HiveField(3, defaultValue: false)
  bool oneToOne;

  LayoutSetting({
    required this.display,
    required this.cleanup,
    required this.shortcuts,
    required this.oneToOne,
  });

  factory LayoutSetting.empty() => LayoutSetting(
        display: DisplayTypes.grid,
        cleanup: false,
        shortcuts: ShortcutsModel.all(),
        oneToOne: false,
      );

  LayoutSetting copyWith({
    bool? cleanup,
    ShortcutsModel? shortcuts,
    DisplayTypes? display,
    bool? oneToOne,
  }) {
    return LayoutSetting(
        display: display ?? this.display,
        cleanup: cleanup ?? this.cleanup,
        shortcuts: shortcuts ?? this.shortcuts,
        oneToOne: oneToOne ?? this.oneToOne);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cleanup': cleanup,
      'shortcuts': shortcuts.toMap(),
      'display': display.name,
      'oneToOne': oneToOne
    };
  }

  factory LayoutSetting.fromMap(Map<String, dynamic> map) {
    return LayoutSetting(
      cleanup: (map['cleanup'] ?? false) as bool,
      shortcuts: ShortcutsModel.fromMap(Map.from(map['shortcuts'] as dynamic)),
      display: DisplayTypes.values
          .firstWhere((e) => e.name == map['display'].toString()),
      oneToOne: (map['oneToOne'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LayoutSetting.fromJson(String source) =>
      LayoutSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LayoutSettings(cleanup: $cleanup, shortcuts: $shortcuts, display: $display, oneToOne: $oneToOne)';

  @override
  bool operator ==(covariant LayoutSetting other) {
    if (identical(this, other)) return true;

    return other.cleanup == cleanup &&
        other.shortcuts == shortcuts &&
        other.display == display &&
        other.oneToOne == oneToOne;
  }

  @override
  int get hashCode =>
      cleanup.hashCode ^
      shortcuts.hashCode ^
      display.hashCode ^
      oneToOne.hashCode;
}
