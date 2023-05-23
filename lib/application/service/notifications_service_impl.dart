import 'dart:async';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/service/notifications_service.dart';

@Singleton(
  as: NotificationsService,
)
class NotificationsServiceImpl implements NotificationsService {
  late final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();

  @override
  StreamSubscription<dynamic>? onMessageOpenedAppSubscription;

  @override
  StreamSubscription<dynamic>? onMessageReceived;

  @override
  StreamSubscription<dynamic>? onMessageSubscription;

  final I18N i18n;

  NotificationsServiceImpl(this.i18n);

  @FactoryMethod(preResolve: true)
  static Future<NotificationsServiceImpl> onInit(I18N i18n) async {
    final service = NotificationsServiceImpl(i18n);
    await service.init();
    return service;
  }

  @override
  Future<NotificationsService> init() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _awesomeNotifications.initialize(
      'resource://mipmap/ic_launcher',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('User declined or has not accepted permission');
    }

    await onMessageSubscription?.cancel();
    await onMessageOpenedAppSubscription?.cancel();
    await onMessageReceived?.cancel();

    onMessageSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message);
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification?.title}  ${message.notification?.body}');
        await showNotification(
          title: message.notification!.title ?? "",
          description: message.notification!.body ?? "",
          payload:
              message.data.map((key, value) => MapEntry(key, value.toString())),
        );
      }
    });
    onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {
      print(message);
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        await showNotification(
          title: message.notification!.title ?? "",
          description: message.notification!.body ?? "",
          payload: message.data as Map<String, String?>?,
        );
      }
    });

    return this;
  }

  @override
  Future<void> showNotification({
    required String title,
    required String description,
    Map<String, String?>? payload,
  }) async {
    title = title.trlf(payload);
    description = description.trlf(payload);

    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: Random().nextInt(1000),
        channelKey: 'basic_channel',
        title: title,
        payload: payload,
        body: description,
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }
}
