import 'package:intl/intl.dart';

extension TimeHelper on DateTime {

  String get timeString {
    return DateFormat("DD/MM/yy HH:mm").format(this);
  }

  DateTime get timezonedDate {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: true).toLocal();
  }
}