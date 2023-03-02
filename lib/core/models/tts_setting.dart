import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/models/subtitles_setting.dart';
import 'package:ottaa_project_flutter/core/models/voice_setting.dart';

part 'tts_setting.g.dart';

@HiveType(typeId: HiveTypesIds.ttsSettingTypeId)
class TTSSetting {
  @HiveField(0)
  VoiceSetting voiceSetting;

  @HiveField(1)
  SubtitlesSetting subtitlesSetting;

  TTSSetting({
    required this.voiceSetting,
    required this.subtitlesSetting,
  });

  factory TTSSetting.empty() {
    return TTSSetting(
      voiceSetting: VoiceSetting.empty(),
      subtitlesSetting: SubtitlesSetting.empty(),
    );
  }

  TTSSetting copyWith({
    VoiceSetting? voiceSetting,
    SubtitlesSetting? subtitlesSetting,
  }) {
    return TTSSetting(
      voiceSetting: voiceSetting ?? this.voiceSetting,
      subtitlesSetting: subtitlesSetting ?? this.subtitlesSetting,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'voice': voiceSetting.toMap(),
      'subtitles': subtitlesSetting.toMap(),
    };
  }

  factory TTSSetting.fromMap(Map<String, dynamic> map) {
    return TTSSetting(
      voiceSetting:
          VoiceSetting.fromMap(map['voice'] as Map<String, dynamic>),
      subtitlesSetting: SubtitlesSetting.fromMap(
          map['subtitles'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory TTSSetting.fromJson(String source) =>
      TTSSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TTSSetting(voice: $voiceSetting, subtitles: $subtitlesSetting)';

  @override
  bool operator ==(covariant TTSSetting other) {
    if (identical(this, other)) return true;

    return other.voiceSetting == voiceSetting &&
        other.subtitlesSetting == subtitlesSetting;
  }

  @override
  int get hashCode => voiceSetting.hashCode ^ subtitlesSetting.hashCode;
}
