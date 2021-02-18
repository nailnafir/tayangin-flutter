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
}
