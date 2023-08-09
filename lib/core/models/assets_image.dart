// ignore_for_file: public_member_api_docs, sort_constructors_first
// coverage:ignore-file
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'assets_image.g.dart';

@HiveType(typeId: HiveTypesIds.assetsTypeId)
class AssetsImage {
  @HiveField(0)
  String asset;

  @HiveField(1)
  String? network;

  AssetsImage({
    required this.asset,
    required this.network,
  });

  AssetsImage copyWith({
    String? asset,
    String? network,
  }) {
    return AssetsImage(
      asset: asset ?? this.asset,
      network: network ?? this.network,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'asset': asset,
      'network': network,
    };
  }

  factory AssetsImage.fromMap(Map<String, dynamic> map) {
    return AssetsImage(
      asset: map['asset'] as String,
      network: map['network'] != null ? map['network'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetsImage.fromJson(String source) =>
      AssetsImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AssetsImage(asset: $asset, network: $network)';

  @override
  bool operator ==(covariant AssetsImage other) {
    if (identical(this, other)) return true;

    return other.asset == asset && other.network == network;
  }

  @override
  int get hashCode => asset.hashCode ^ network.hashCode;
}
