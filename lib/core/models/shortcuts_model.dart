import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'shortcuts_model.g.dart';

@HiveType(typeId: HiveTypesIds.shortcutsTypeId)
class ShortcutsModel {
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

  ShortcutsModel({
    required this.enable,
    required this.favs,
    required this.history,
    required this.camera,
    required this.share,
    required this.games,
    required this.no,
    required this.yes,
  });

  factory ShortcutsModel.none() => ShortcutsModel(
        enable: false,
        favs: false,
        history: false,
        camera: false,
        share: false,
        games: false,
        yes: false,
        no: false,
      );
  factory ShortcutsModel.all() => ShortcutsModel(
        enable: true,
        favs: true,
        history: true,
        camera: true,
        share: true,
        games: true,
        yes: true,
        no: true,
      );
  ShortcutsModel copyWith({
    bool? favs,
    bool? history,
    bool? camera,
    bool? share,
    bool? games,
    bool? yes,
    bool? no,
    bool? enable,
  }) {
    return ShortcutsModel(
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

  factory ShortcutsModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return ShortcutsModel.none().copyWith(
      enable: map['enable'],
      favs: map['favs'],
      history: map['history'],
      camera: map['camera'],
      share: map['share'],
      games: map['games'],
      yes: map['yes'],
      no: map['no'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShortcutsModel.fromJson(String source) => ShortcutsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shortcuts(favs: $favs, history: $history, camera: $camera, share: $share, games: $games)';
  }

  @override
  bool operator ==(covariant ShortcutsModel other) {
    if (identical(this, other)) return true;

    return other.favs == favs && other.history == history && other.camera == camera && other.share == share && other.games == games;
  }

  @override
  int get hashCode {
    return favs.hashCode ^ history.hashCode ^ camera.hashCode ^ share.hashCode ^ games.hashCode;
  }
}
