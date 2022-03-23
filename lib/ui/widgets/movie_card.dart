part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;
  final int currentIndex;
  final int itemIndex;
  final int pageViewIndex;

  MovieCard(this.movie,
      {this.onTap, this.currentIndex, this.itemIndex, this.pageViewIndex});

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
            period: Duration(seconds: 1),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Container(
              height: 300,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(defaultMargin / 2),
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultMargin / 2),
                      image: DecorationImage(
                        image: NetworkImage(imageBaseURL +
                            "w780" +
                            (movie.backdropPath ?? movie.posterPath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: (currentIndex == itemIndex) ||
                            (currentIndex == pageViewIndex)
                        ? Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(defaultMargin / 2),
                                ),
                                color: mainColorPrimary.withOpacity(0.8)),
                            child: Center(
                              child: Text("Beli Tiket",
                                  style: whiteTextFont.copyWith(fontSize: 18)),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
              SizedBox(height: defaultMargin / 2),
              Text(
                movie.title,
                style: blackTextFont.copyWith(fontSize: 16, height: 1),
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                maxLines: 2,
              ),
              SizedBox(height: defaultMargin / 8),
              RatingStars(
                voteAverage: movie.voteAverage,
                alignment: MainAxisAlignment.center,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
