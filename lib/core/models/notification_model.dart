import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationModel {
  final String title;
  final String body;
  final Map<String, dynamic> data;

  const NotificationModel({
    required this.title,
    required this.body,
    this.data = const <String, dynamic>{},
  });

  NotificationModel copyWith({
    String? title,
    String? body,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'data': data,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      body: map['body'] as String,
      data: Map<String, dynamic>.from((map['data'] as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotificationModel(title: $title, body: $body, data: $data)';

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.body == body &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ data.hashCode;
}
