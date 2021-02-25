part of 'models.dart';

class TayanginTransaction extends Equatable {
  // buat getter
  final String userID;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;

  // constructor
  TayanginTransaction(
      {@required this.userID,
      @required this.title,
      @required this.subtitle,
      this.amount = 0,
      @required this.time,
      this.picture});

  @override
  List<Object> get props => [userID, title, subtitle, amount, time, picture];
}
