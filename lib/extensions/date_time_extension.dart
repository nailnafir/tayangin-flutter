part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  // membuat getter
  String get dayName {
    switch (this.weekday) {
      case 1:
        return "SENIN";
      case 2:
        return "SELASA";
      case 3:
        return "RABU";
      case 4:
        return "KAMIS";
      case 5:
        return "JUMAT";
      case 6:
        return "SABTU";
      default:
        return "MINGGU";
    }
  }

  String get monthName {
    switch (this.month) {
      case 1:
        return "JAN";
      case 2:
        return "FEB";
      case 3:
        return "MAR";
      case 4:
        return "APR";
      case 5:
        return "MEI";
      case 6:
        return "JUN";
      case 7:
        return "JUL";
      case 8:
        return "AGU";
      case 9:
        return "SEP";
      case 10:
        return "OKT";
      case 11:
        return "NOV";
      default:
        return "DES";
    }
  }
}
