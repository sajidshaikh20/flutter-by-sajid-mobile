import 'exports.dart';

/// A class containing common date and time format constants.
class DateConstants {
  /// Date-time format: `yyyy-MM-dd HH:mm:ss`
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  /// Date format: `yyyy-MM-dd`
  static const String yearMonthDayFormat = 'yyyy-MM-dd';

  /// Date format: `dd-MMM-yyyy`
  static const String dateMonthYearFormat = 'dd-MMM-yyyy';

  /// Date format: `dd MMM yyyy`
  static const String dateMonthYearOnlyFormat = 'dd MMM yyyy';

  /// Desired display format
  static const String dateTimeWithAmPmFormat = 'dd MMM yyyy , hh:mm a';

  /// 12-hour time format with AM/PM: `hh:mm a`
  static const String hours12WithMeridiemFormat = 'hh:mm a';

  /// ISO 8601 timestamp format: `yyyy-MM-ddTHH:mm:ss.SSS`
  static const String timestampFormat = 'yyyy-MM-ddTHH:mm:ss.SSS';

  /// 24-hour time format: `HH:mm`
  static const String hour24Format = 'HH:mm';

  ///dateOfBirthFormat dd-MM-yyyy
  static const String dateOfBirthFormat = 'dd-MM-yyyy';

  ///dateOfBirthFormat dd-MM-yyyy
  static const String dateOfBirthConvertedFormat = 'dd/MM/yyyy';
}

/// Returns the current date formatted as per the given [dateFormat].
String getCurrentDateString(String dateFormat) {
  unawaited(initializeDateFormatting());
  return DateFormat(dateFormat).format(DateTime.now());
}

/// Returns the current UTC date formatted in [DateConstants.dateTimeFormat].
String getUtcDate() {
  DateTime dateUtc = DateTime.now().toUtc();
  String date = DateFormat(DateConstants.dateTimeFormat).format(dateUtc);
  return date;
}

/// Converts a UTC date string to local time in a specified format.
String getLocalTime(String dateUtc, {String? format, bool isUtc = false}) {
  // convert it to local
  DateTime dateTime =
  DateFormat(format ?? DateConstants.dateTimeFormat).parse(dateUtc, isUtc);
  DateTime dateLocal = dateTime.toLocal();
  return DateFormat(DateConstants.hours12WithMeridiemFormat).format(dateLocal);
}

/// Converts a [DateTime] object to a string in the specified format.
String dateToString(
    DateTime date, {
      String dateFormat = DateConstants.dateMonthYearFormat,
    }) =>
    DateFormat(dateFormat).format(date);

/// Converts a string date to [DateTime] using the specified format.
DateTime stringToDate(
    String dateString, {
      String dateFormat = DateConstants.dateMonthYearFormat,
    }) {
  try {
    return DateFormat(dateFormat).parse(dateString);
  } on Exception {
    return DateTime.now();
  }
}

/// Converts a [DateTime] to an ISO 8601 string format.
String dateToISOString(DateTime date) =>
    DateFormat(DateConstants.timestampFormat).format(date);

/// Converts a date string (from API response) to the desired format.
String getConvertedDate(
    String dateString, {
      String dateFormat = DateConstants.dateMonthYearFormat,
    }) {
  try {
    DateTime dateTime = DateFormat(DateConstants.dateTimeFormat).parse(dateString);
    String formattedDate = DateFormat(dateFormat).format(dateTime.toLocal());
    return formattedDate;
  } on Exception {
    return '';
  }
}

/// Converts a date string (from API response) to a time format.
String getConvertedTime(String dateString) {
  try {
    DateTime dateTime = DateFormat(DateConstants.dateTimeFormat).parse(dateString);
    String formattedDate = DateFormat(DateConstants.hours12WithMeridiemFormat)
        .format(dateTime.toLocal());
    return formattedDate;
  } on Exception {
    return '';
  }
}
/// Converts a date string from `dd-MM-yyyy` to `dd/MM/yyyy`
/// specifically used for signup forms.
String convertDateFormatForSignup(String dateString) {
  try {
    return convertedDateFormat(
      dateString,
      fromThis: DateConstants.dateOfBirthFormat, // dd-MM-yyyy
      toThis: DateConstants.dateOfBirthConvertedFormat, //dd/MM/yyyy
    );
  } on Exception {
    return dateString;
  }
}

/// Converts a date string from one format to another.
String convertedDateFormat(
    String dateString, {
      String fromThis = DateConstants.dateTimeFormat,
      String toThis = DateConstants.dateMonthYearFormat,
    }) {
  DateTime dateTime = DateFormat(fromThis).parse(dateString);
  String formattedDate = DateFormat(toThis).format(dateTime.toLocal());
  return formattedDate;
}

/// Converts a UTC date string to local time formatted string
String utcToLocal(String utcString) {
  if (utcString.isEmpty) return '';
  // Parse the UTC string
  DateTime utcTime = DateTime.parse(utcString).toUtc();

  // Convert to local timezone
  DateTime localTime = utcTime.toLocal();

  // Format the date
  return DateFormat(DateConstants.dateTimeFormat).format(localTime);

}
/// utcToDateFormate
String utcToDateFormate(String utcString,String? dateMonthYearFormat) {
  if (utcString.isEmpty) return '';

  DateTime utcTime = DateTime.parse(utcString).toUtc();
  DateTime localTime = utcTime.toLocal();
  return DateFormat(dateMonthYearFormat).format(localTime);

}

/// Parses a UTC date string and returns it in a human-readable format.
String parseDate(String dateUtc) {
  DateTime date = DateFormat(DateConstants.dateTimeFormat).parse(dateUtc, true);
  DateTime dateLocal = date.toLocal();
  String formattedDate =
  DateFormat(DateConstants.yearMonthDayFormat).format(dateLocal);
  String currentDate =
  DateFormat(DateConstants.yearMonthDayFormat).format(DateTime.now());
  if (formattedDate == currentDate) {
    return DateFormat(DateConstants.hours12WithMeridiemFormat)
        .format(dateLocal)
        .replaceAll(' ', '')
        .toLowerCase();
  }
  return DateFormat(DateConstants.dateMonthYearFormat).format(dateLocal);
}

/// Returns a list of all the days between two given dates.
List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = <DateTime>[];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}

/// Returns the difference between two times in a human-readable format.
String twoTimeDifference(
    String startTime,
    String endTime, {
      String? startTimeFormat = DateConstants.hours12WithMeridiemFormat,
      String? endTimeFormat = DateConstants.hours12WithMeridiemFormat,
      String? outputFormat = DateConstants.hour24Format,
    }) {
  DateTime sTime = stringToDate(startTime, dateFormat: startTimeFormat!);
  DateTime eTime = stringToDate(endTime, dateFormat: endTimeFormat!);
  Duration difference = eTime.difference(sTime);
  return DateFormat(outputFormat)
      .format(DateTime(0, 0, 0, 0, difference.inMinutes));
}
