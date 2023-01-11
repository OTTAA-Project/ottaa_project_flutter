import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'shortcuts_model.g.dart';

@HiveType(typeId: HiveTypesIds.shortcutsTypeId)
class Shortcuts {
  @HiveField(0, defaultValue: false)
  bool favs;

  @HiveField(1, defaultValue: false)
  bool gallery;

  @HiveField(2, defaultValue: false)
  bool games;

  @HiveField(3, defaultValue: false)
  bool share;

  @HiveField(4, defaultValue: false)
  bool shuffle;

  Shortcuts({
    required this.favs,
    required this.gallery,
    required this.games,
    required this.share,
    required this.shuffle,
  });

  Shortcuts copyWith({
    bool? favs,
    bool? gallery,
    bool? games,
    bool? share,
    bool? shuffle,
  }) {
    return Shortcuts(
      favs: favs ?? this.favs,
      gallery: gallery ?? this.gallery,
      games: games ?? this.games,
      share: share ?? this.share,
      shuffle: shuffle ?? this.shuffle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favs': favs,
      'gallery': gallery,
      'games': games,
      'share': share,
      'shuffle': shuffle,
    };
  }

  factory Shortcuts.fromMap(Map<String, dynamic> map) {
    return Shortcuts(
      favs: map['favs'] as bool,
      gallery: map['gallery'] as bool,
      games: map['games'] as bool,
      share: map['share'] as bool,
      shuffle: map['shuffle'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shortcuts.fromJson(String source) => Shortcuts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Shortcuts(favs: $favs, gallery: $gallery, games: $games, share: $share, shuffle: $shuffle)';
  }

  @override
  bool operator ==(covariant Shortcuts other) {
    if (identical(this, other)) return true;

    return other.favs == favs && other.gallery == gallery && other.games == games && other.share == share && other.shuffle == shuffle;
  }

  @override
  int get hashCode {
    return favs.hashCode ^ gallery.hashCode ^ games.hashCode ^ share.hashCode ^ shuffle.hashCode;
  }
}
