part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final String backdropPath;

  Movie(
      {@required this.id,
      @required this.title,
      @required this.voteAverage,
      @required this.overview,
      @required this.posterPath,
      @required this.backdropPath});

  @override
  // TODO: implement props
  List<Object> get props =>
      [id, title, voteAverage, overview, posterPath, backdropPath];
}
