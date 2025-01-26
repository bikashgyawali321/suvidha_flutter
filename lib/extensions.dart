import 'package:intl/intl.dart';

DateFormat get _dateTimeFormat => DateFormat('yyyy-MM-dd hh:mm aa');
DateFormat get _verbalDate => DateFormat('MMM dd, yyyy');
DateFormat get _verbalDateTime => DateFormat('dd MMM yyyy  hh:mm aa');
DateFormat get _verbalTime => DateFormat('hh:mm aa');

extension DateX on DateTime {
  String get toDateTime {
    return _dateTimeFormat.format(this);
  }

  String get toVerbalDate {
    return _verbalDate.format(this);
  }

  String get toVerbalDateTime {
    return _verbalDateTime.format(this);
  }

  String get toVerbalTime {
    return _verbalTime.format(this);
  }
}
