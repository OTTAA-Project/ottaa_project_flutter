import 'package:intl/intl.dart';

extension TimeHelper on DateTime {
  String get timeString {
    return DateFormat("dd/MM/yy HH:mm").format(this);
  }

  DateTime get timezonedDate {
    final timeZoneOffset = DateTime.now().timeZoneOffset;
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: false).add(timeZoneOffset).toLocal();
  }
}
