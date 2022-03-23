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
              margin: EdgeInsets.all(4),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(defaultMargin / 2),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultMargin / 2),
            ),
            elevation: 2,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(defaultMargin / 2),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultMargin / 2),
                      image: DecorationImage(
                        image: NetworkImage(imageBaseURL +
                            "w780" +
                            (movie.posterPath ?? movie.backdropPath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: defaultMargin / 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Text(
                          movie.title,
                          maxLines: 2,
                          style:
                              blackTextFont.copyWith(fontSize: 18, height: 1.2),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(height: defaultMargin / 8),
                      RatingStars(
                        voteAverage: movie.voteAverage,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
