// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:intl/intl.dart';

DateFormat get _dateTimeFormat => DateFormat('yyyy-MM-dd hh:mm aa');
DateFormat get _verbalDate => DateFormat('MMM dd, yyyy');
DateFormat get _verbalDateTime => DateFormat('dd MMM yyyy  hh:mm aa');
DateFormat get _verbalTime => DateFormat('hh:mm aa');
DateFormat get _markerDate => DateFormat('EEE, dd MMM');

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

  String get toMarkerDate {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      return 'Today at ' + _verbalTime.format(this);
    } else if (difference.inDays == 1) {
      return 'Yesterday at ' + _verbalTime.format(this);
    } else {
      return _markerDate.format(this) + ' at ' + _verbalTime.format(this);
    }
  }
}

extension CurrencyX on num {
  String get toCurrency {
    return 'Rs. ${toStringAsFixed(truncateToDouble() == this ? 0 : 2)}';
  }
}
