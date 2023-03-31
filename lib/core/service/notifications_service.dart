import 'dart:async';

abstract class NotificationsService {
  StreamSubscription<dynamic>? onMessageSubscription;
  StreamSubscription<dynamic>? onMessageOpenedAppSubscription;
  StreamSubscription<dynamic>? onMessageReceived;

  Future<NotificationsService> init();

  Future<void> showNotification({
    required String title,
    required String description,
    Map<String, String?>? payload,
  });
}
