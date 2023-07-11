// ignore_for_file: public_member_api_docs, sort_constructors_first
// coverage:ignore-file
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/enums/size_types.dart';
import 'package:ottaa_project_flutter/core/enums/velocity_types.dart';

part 'subtitles_setting.g.dart';

@HiveType(typeId: HiveTypesIds.subtitlesSettingTypeId)
class SubtitlesSetting {
  @HiveField(0, defaultValue: false)
  bool show;

  @HiveField(1, defaultValue: SizeTypes.mid)
  SizeTypes size;

  @HiveField(2, defaultValue: false)
  bool caps;

  SubtitlesSetting({
    required this.show,
    required this.size,
    required this.caps,
  });

  factory SubtitlesSetting.empty() {
    return SubtitlesSetting(
      show: false,
      size: SizeTypes.mid,
      caps: false,
    );
  }

  SubtitlesSetting copyWith({
    bool? show,
    SizeTypes? size,
    bool? caps,
  }) {
    return SubtitlesSetting(
      show: show ?? this.show,
      size: size ?? this.size,
      caps: caps ?? this.caps,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'show': show,
      'size': size.name,
      'caps': caps,
    };
  }

  factory SubtitlesSetting.fromMap(Map<String, dynamic> map) {
    return SubtitlesSetting(
      show: map['show'] as bool,
      size: SizeTypes.values.firstWhere(
        (e) => e.name == map['size'].toString(),
        orElse: () => SizeTypes.mid,
      ),
      caps: map['caps'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubtitlesSetting.fromJson(String source) =>
      SubtitlesSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubtitlesSetting(show: $show, size: $size, caps: $caps)';

  @override
  bool operator ==(covariant SubtitlesSetting other) {
    if (identical(this, other)) return true;

    return other.show == show && other.size == size && other.caps == caps;
  }

  @override
  int get hashCode => show.hashCode ^ size.hashCode ^ caps.hashCode;
}
