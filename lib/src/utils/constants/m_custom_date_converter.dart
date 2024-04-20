
import 'package:intl/intl.dart';

class MyDateConverter {
  static String convertTaskTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String isoStringToLocalAMPM(DateTime dateTime) {
    return DateFormat('a').format(dateTime);
  }
  static String isoStringToLocalTimeOnly(DateTime dateTime) {
    return DateFormat('hh:mm aa').format(dateTime);
  }

  static String dayMonthYearConvert(String dateTime) {
    DateTime date = DateFormat("dd-MM-yyyy", "en_US").parse(dateTime);
    return DateFormat("dd MMM yy").format(date);
  }
}
