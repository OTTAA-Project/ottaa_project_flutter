import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/service/notifications_service.dart';

@Singleton(
  as: NotificationsService,
)
class NotificationsServiceImpl implements NotificationsService<RemoteMessage> {
  @override
  StreamSubscription<RemoteMessage>? onMessageOpenedAppSubscription;

  @override
  StreamSubscription<RemoteMessage>? onMessageReceived;

  @override
  StreamSubscription<RemoteMessage>? onMessageSubscription;

  @override
  Future<NotificationsService> init() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('User declined or has not accepted permission');
    }

    await onMessageSubscription?.cancel();
    await onMessageOpenedAppSubscription?.cancel();
    await onMessageReceived?.cancel();

    onMessageSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message);
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    onMessageOpenedAppSubscription = FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message);
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    return this;
  }
}
