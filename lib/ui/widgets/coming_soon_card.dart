part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  ComingSoonCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
            image: NetworkImage(imageBaseURL + "w780" + movie.posterPath),
            fit: BoxFit.cover),
      ),
    );
  }
}
