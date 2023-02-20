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
  Shortcuts shortcuts;

  @HiveField(2, defaultValue: DisplayTypes.grid)
  DisplayTypes display;

  LayoutSetting({
    required this.display,
    required this.cleanup,
    required this.shortcuts,
  });

  factory LayoutSetting.build() => LayoutSetting(
        display: DisplayTypes.grid,
        cleanup: false,
        shortcuts: Shortcuts.none(),
      );

  LayoutSetting copyWith({
    bool? cleanup,
    Shortcuts? shortcuts,
    DisplayTypes? display,
  }) {
    return LayoutSetting(
      display: display ?? this.display,
      cleanup: cleanup ?? this.cleanup,
      shortcuts: shortcuts ?? this.shortcuts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cleanup': cleanup,
      'shortcuts': shortcuts.toMap(),
      'display': display.name,
    };
  }

  factory LayoutSetting.fromMap(Map<String, dynamic> map) {
    return LayoutSetting(
      cleanup: (map['cleanup'] ?? false) as bool,
      shortcuts: Shortcuts.fromMap(Map.from(map['shortcuts'] as dynamic)),
      display: DisplayTypes.values.firstWhere((e) => e.name == map['display'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory LayoutSetting.fromJson(String source) => LayoutSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LayoutSettings(cleanup: $cleanup, shortcuts: $shortcuts, display: $display)';

  @override
  bool operator ==(covariant LayoutSetting other) {
    if (identical(this, other)) return true;

    return other.cleanup == cleanup && other.shortcuts == shortcuts && other.display == display;
  }

  @override
  int get hashCode => cleanup.hashCode ^ shortcuts.hashCode ^ display.hashCode;
}
