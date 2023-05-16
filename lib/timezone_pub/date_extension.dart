import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

extension DateExtension on DateTime {
  tz.TZDateTime toTZDateTime(String timeZone) {
    return tz.TZDateTime(
        tz.getLocation(timeZone), year, month, day, hour, minute);
  }

  String toFormattedString() {
    final formatter = DateFormat('yyyy年MM月dd日H時', 'ja_JP');
    return formatter.format(this);
  }
}
