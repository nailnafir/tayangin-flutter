part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo(
      {@required this.title, @required this.subtitle, @required this.discount});

  @override
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromo = [
  Promo(
      title: "Liburan Pelajar",
      subtitle: "Maksimal hanya dua orang",
      discount: 50),
  Promo(
      title: "Liburan Keluarga",
      subtitle: "Maksimal hanya tiga orang",
      discount: 25),
  Promo(
      title: "Member Istimewa",
      subtitle: "Minimal langganan satu tahun",
      discount: 70),
];
