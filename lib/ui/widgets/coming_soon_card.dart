part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  ComingSoonCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            period: Duration(seconds: 1),
            child: Container(
              width: 140,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Container(
            width: 140,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(imageBaseURL +
                      "w780" +
                      (movie.posterPath ?? movie.backdropPath)),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
