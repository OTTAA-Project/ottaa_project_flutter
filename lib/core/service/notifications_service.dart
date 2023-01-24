import 'dart:async';

abstract class NotificationsService<T> {
  StreamSubscription<T>? onMessageSubscription;
  StreamSubscription<T>? onMessageOpenedAppSubscription;
  StreamSubscription<T>? onMessageReceived;

  Future<NotificationsService> init();
}
