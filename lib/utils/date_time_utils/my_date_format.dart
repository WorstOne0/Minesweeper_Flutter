// ignore_for_file: constant_identifier_names

// Flutter Packages
import 'package:intl/intl.dart';

// Enhanced Enums (https://dart.dev/language/enums)
enum MyDateFormat {
  DATE_TIME_REQUEST('yyyy-MM-dd HH:mm:ss'),
  DATE_TIME_REQUEST_NO_SEC('yyyy-MM-dd HH:mm'),
  DATE_TIME_RESULT('dd-MM-yyyy HH:mm:ss'),
  DATE_RESULT('dd-MM-yyyy'),
  DATE_BR('dd/MM/yyyy'),
  TIME_BR('HH:mm:ss'),
  TIME('HH:mm'),
  DATE_TIME_BR('dd/MM/yyyy HH:mm:ss'),
  DATE_TIME_BR_NO_SECONDS('dd/MM/yyyy HH:mm'),
  DAY_MONTH_HOUR('EEE d MMM HH:mm:ss'),
  DAY_MONTH_HOUR_NO_SECONDS('EEE d MMM HH:mm'),
  DAY_MONTH_YEAR('EEE d MMM yyyy'),
  WEEK_DAY('EEEE'),
  MONTH('MMMM'),
  MONTH_DAY('MMM d'),
  MONTH_YEAR('MMM yyyy'),
  MONTH_DAY_YEAR('MMM d, yyyy'),
  YEAR_MONTH_DAY('yyyy-MM-dd'),
  MONGO_DB('yyyy-MM-ddTHH:mm:ssZ'),
  YEAR_MONTH_DAY_HOUR_MINUTES_SECONDS('yyyyMMddHHmmss');

  const MyDateFormat(this.strDate);
  final String strDate;

  String? format(DateTime? value, {String? defValue}) {
    try {
      return DateFormat(strDate, 'pt_Br').format(value!);
    } catch (e) {
      return defValue;
    }
  }

  DateTime? parse(String? value, {DateTime? defValue}) {
    try {
      return DateFormat(strDate).parse(value!);
    } catch (e) {
      return defValue;
    }
  }
}
