import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'shortcuts_model.g.dart';

@HiveType(typeId: HiveTypesIds.shortcutsTypeId)
class Shortcuts {
  @HiveField(0, defaultValue: false)
  bool favs;

  @HiveField(1, defaultValue: false)
  bool history;

  @HiveField(2, defaultValue: false)
  bool camera;

  @HiveField(3, defaultValue: false)
  bool share;

  @HiveField(4, defaultValue: false)
  bool games;

  @HiveField(5, defaultValue: false)
  bool yes;

  @HiveField(6, defaultValue: false)
  bool no;

  @HiveField(7, defaultValue: false)
  bool enable;

  Shortcuts({
    required this.enable,
    required this.favs,
    required this.history,
    required this.camera,
    required this.share,
    required this.games,
    required this.no,
    required this.yes,
  });

  factory Shortcuts.none() => Shortcuts(
        enable: false,
        favs: false,
        history: false,
        camera: false,
        share: false,
        games: false,
        yes: false,
        no: false,
      );

  Shortcuts copyWith({
    bool? favs,
    bool? history,
    bool? camera,
    bool? share,
    bool? games,
    bool? yes,
    bool? no,
    bool? enable,
  }) {
    return Shortcuts(
      enable: enable ?? this.enable,
      favs: favs ?? this.favs,
      history: history ?? this.history,
      camera: camera ?? this.camera,
      share: share ?? this.share,
      games: games ?? this.games,
      yes: yes ?? this.yes,
      no: no ?? this.no,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enable': enable,
      'favs': favs,
      'history': history,
      'camera': camera,
      'share': share,
      'games': games,
      'yes': yes,
      'no': no,
    };
  }

  factory Shortcuts.fromMap(Map<String, dynamic> map) {
    return Shortcuts(
      enable: map['enable'] ?? false,
      favs: map['favs'] == null ? false : map['favs'] as bool,
      history: map['history'] == null ? false : map['history'] as bool,
      camera: map['camera'] == null ? false : map['camera'] as bool,
      share: map['share'] == null ? false : map['share'] as bool,
      games: map['games'] as bool,
      yes: map['yes'] as bool,
      no: map['no'] == null ? false : map['no'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shortcuts.fromJson(String source) => Shortcuts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shortcuts(favs: $favs, history: $history, camera: $camera, share: $share, games: $games)';
  }

  @override
  bool operator ==(covariant Shortcuts other) {
    if (identical(this, other)) return true;

    return other.favs == favs && other.history == history && other.camera == camera && other.share == share && other.games == games;
  }

  @override
  int get hashCode {
    return favs.hashCode ^ history.hashCode ^ camera.hashCode ^ share.hashCode ^ games.hashCode;
  }
}
