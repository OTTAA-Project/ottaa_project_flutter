// To parse this JSON data, do
//
//     final voices = voicesFromJson(jsonString);
// coverage:ignore-file
import 'dart:convert';

List<Voices> voicesFromJson(String str) =>
    List<Voices>.from(json.decode(str).map((x) => Voices.fromJson(x)));

String voicesToJson(List<Voices> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Voices {
  Voices({
    required this.name,
    required this.locale,
  });

  String name;
  String locale;

  factory Voices.fromJson(Map<String, dynamic> json) => Voices(
        name: json["name"],
        locale: json["locale"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "locale": locale,
      };
}
