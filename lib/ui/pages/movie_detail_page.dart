part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: mainColorBlue,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            ListView(
              children: <Widget>[
                FutureBuilder(
                    future: MovieServices.getDetails(movie),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        movieDetail = snapshot.data;
                      }

                      return Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              //NOTE: BACKDROP
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseURL +
                                                  "w1280" +
                                                  movie.backdropPath ??
                                              movie.posterPath),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(0, 1),
                                        end: Alignment(0, 0.05),
                                        colors: [
                                          Colors.white,
                                          Colors.white.withOpacity(0),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // NOTE: BACK ICON
                              Container(
                                margin: EdgeInsets.only(
                                    left: defaultMargin, top: 16),
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black.withOpacity(0.05)),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToMainPage());
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          // NOTE: TITLE
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 12, defaultMargin, 6),
                            child: Text(movie.title,
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(
                                    fontSize: 24, fontWeight: FontWeight.w500)),
                          ),
                          // NOTE: GENRE
                          (snapshot.hasData)
                              ? Text(
                                  movieDetail.genresAndLanguage,
                                  style: grayTextFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              : SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: SpinKitFadingCircle(
                                    color: mainColorBlue,
                                  ),
                                ),
                          SizedBox(height: 6),
                          // NOTE: RATING
                          RatingStars(
                            voteAverage: movie.voteAverage,
                            color: accentColorDarkGray,
                            alignment: MainAxisAlignment.center,
                          ),
                          SizedBox(height: 30),
                          // NOTE: CREDITS CASTER
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: defaultMargin, bottom: 12),
                              child: Text(
                                "Pemeran",
                                style: blackTextFont.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          FutureBuilder(
                              future: MovieServices.getCredits(movie.id),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  credits = snapshot.data;
                                  return SizedBox(
                                    height: 125,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) => Container(
                                        child: CreditCard(credits[index]),
                                      ),
                                    ),
                                  );
                                }
                              })
                        ],
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
