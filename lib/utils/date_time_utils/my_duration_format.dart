// ignore_for_file: constant_identifier_names

// Flutter Packages
import 'package:intl/intl.dart';

// Enhanced Enums (https://dart.dev/language/enums)
enum MyDurationFormat {
  SECONDS('SECONDS'),
  MINUTES('MINUTES'),
  HOUR('HOUR'),
  DAY('DAY'),
  HOUR_MINUTE('HOUR_MINUTE'),
  MINUTE_SECOND('MINUTE_SECOND'),
  HOUR_MINUTE_SECOND('HOUR_MINUTE_SECOND'),
  DAY_HOUR_MINUTE('DAY_HOUR_MINUTE'),
  DAY_HOUR_MINUTE_COLON('DAY_HOUR_MINUTE_COLON');

  const MyDurationFormat(this.durationType);
  final String durationType;

  String format(Duration duration, {String suffix = ""}) {
    final splittedDuration = resolveDuration(duration);

    String formatedDuration = switch (durationType) {
      "SECONDS" => "${splittedDuration.secondsWhole}s",
      "MINUTES" => "${splittedDuration.minutesWhole}m",
      "HOUR" => "${splittedDuration.hoursWhole}h",
      "DAY" => "${splittedDuration.days}d",
      "HOUR_MINUTE" =>
        "${removeOnEmpty(splittedDuration.hoursWhole, "h")}${removeOnEmpty(splittedDuration.minutesMod, "m")}",
      "MINUTE_SECOND" =>
        "${zeroOnEmpty(splittedDuration.minutesWhole, "")}:${zeroOnEmpty(splittedDuration.secondsMod, "")}",
      "HOUR_MINUTE_SECOND" =>
        "${removeOnEmpty(splittedDuration.hoursWhole, "h")}${removeOnEmpty(splittedDuration.minutesMod, "m")}${removeOnEmpty(splittedDuration.secondsMod, "s")}",
      "DAY_HOUR_MINUTE" =>
        "${removeOnEmpty(splittedDuration.days, "d ")}${removeOnEmpty(splittedDuration.hoursMod, "h")}${removeOnEmpty(splittedDuration.minutesMod, "m")}",
      "DAY_HOUR_MINUTE_COLON" =>
        "${removeOnEmpty(splittedDuration.days, "d ")}${zeroOnEmpty(splittedDuration.hoursMod, "")}:${zeroOnEmpty(splittedDuration.minutesMod, "")}",
      _ => ""
    };

    return "$formatedDuration$suffix";
  }
}

({
  String days,
  String hoursWhole,
  String hoursMod,
  String minutesWhole,
  String minutesMod,
  String secondsWhole,
  String secondsMod
}) resolveDuration(Duration duration) {
  String days = "",
      hoursWhole = "",
      hoursMod = "",
      minutesWhole = "",
      minutesMod = "",
      secondsWhole = "",
      secondsMod = "";

  if (duration.inDays > 0) {
    days = (duration.inDays).toString().padLeft(2, '0');
  }

  if (duration.inHours > 0) {
    hoursWhole = duration.inHours.toString().padLeft(2, '0');
    hoursMod = (duration.inHours % 24).toString().padLeft(2, '0');
  }

  if (duration.inMinutes > 0) {
    minutesWhole = duration.inMinutes.toString().padLeft(2, '0');
    minutesMod = (duration.inMinutes % 60).toString().padLeft(2, '0');
  }

  if (duration.inSeconds > 0) {
    secondsWhole = duration.inSeconds.toString().padLeft(2, '0');
    secondsMod = (duration.inSeconds % 60).toString().padLeft(2, '0');
  }

  return (
    days: days,
    hoursWhole: hoursWhole,
    hoursMod: hoursMod,
    minutesWhole: minutesWhole,
    minutesMod: minutesMod,
    secondsWhole: secondsWhole,
    secondsMod: secondsMod
  );
}

String removeOnEmpty(String value, String suffix) {
  return value.isEmpty ? "" : "$value$suffix";
}

String zeroOnEmpty(String value, String suffix) {
  return value.isEmpty ? "00" : "$value$suffix";
}

// https://stackoverflow.com/questions/70594474/get-the-dates-of-given-week-number-in-flutter
DateTime getDatesFromWeekNumber(DateTime date) {
  int weekNumber = getWeekNumber(date);

  // first day of the year
  final DateTime firstDayOfYear = DateTime.utc(date.year, 1, 1);

  // first day of the year weekday (Monday, Tuesday, etc...)
  final int firstDayOfWeek = firstDayOfYear.weekday;

  // Calculate the number of days to the first day of the week (an offset)
  final int daysToFirstWeek = (8 - firstDayOfWeek) % 7;

  // Get the date of the first day of the week
  final DateTime firstDayOfGivenWeek =
      firstDayOfYear.add(Duration(days: daysToFirstWeek + (weekNumber - 1) * 7));

  // Get the last date of the week
  // final DateTime lastDayOfGivenWeek = firstDayOfGivenWeek.add(const Duration(days: 6));

  // Return a WeekDates object containing the first and last days of the week
  return firstDayOfGivenWeek;
}

// https://stackoverflow.com/questions/49393231/how-to-get-day-of-year-week-of-year-from-a-datetime-dart-object
int getWeekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  int woy = ((dayOfYear - date.weekday + 10) / 7).floor();

  if (woy < 1) {
    woy = numOfWeeks(date.year - 1);
  } else if (woy > numOfWeeks(date.year)) {
    woy = 1;
  }

  // If is Sunday add a week
  // So the week start at Sunday
  if (date.weekday == 7) {
    woy++;
  }

  return woy;
}

int numOfWeeks(int year) {
  DateTime dec28 = DateTime(year, 12, 28);
  int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
  return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
}
