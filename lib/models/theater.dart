part of 'models.dart';

class Theater extends Equatable {
  final String name;
  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  Theater("XXI CBD Ciledug"),
  Theater("CGV Transmart Graha Raya"),
  Theater("XXI Bintaro Plaza"),
  Theater("CGV Teras Kota BSD"),
];
