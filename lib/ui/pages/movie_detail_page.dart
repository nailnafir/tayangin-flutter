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
                child: ListView(
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
                                    children: [
                                      Shimmer.fromColors(
                                        period: Duration(seconds: 1),
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        child: Container(
                                          height: 250,
                                          color: Colors.grey,
                                        ),
                                      ),
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
                                        height: 252,
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
                                      ),
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
                                    defaultMargin, 4, defaultMargin, 2),
                                child: Text(movie.title,
                                    textAlign: TextAlign.center,
                                    style: blackTextFont.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500)),
                              ),
                              // NOTE: GENRE
                              (snapshot.hasData)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin,
                                      child: Text(
                                        movieDetail.genresAndLanguage,
                                        overflow: TextOverflow.clip,
                                        maxLines: 2,
                                        style: grayTextFont.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: SpinKitThreeBounce(
                                        size: 12,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                  future: MovieServices.getCredits(movie.id),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      credits = snapshot.data;
                                      return SizedBox(
                                        height: 116,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: credits.length,
                                          itemBuilder: (_, index) => Container(
                                            margin: EdgeInsets.only(
                                              left: (index == 0)
                                                  ? defaultMargin
                                                  : 0,
                                              right:
                                                  (index == credits.length - 1)
                                                      ? defaultMargin
                                                      : 12,
                                            ),
                                            child: CreditCard(credits[index]),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox(
                                        height: 116,
                                        width: 116,
                                        child: SpinKitThreeBounce(
                                          color: mainColorBlue,
                                          size: 50,
                                        ),
                                      );
                                    }
                                  })
                            ],
                          );
                        }),
                    // NOTE: STORYLINE
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 30, defaultMargin, 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sinopsis",
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 0, defaultMargin, 30),
                      child: Text(
                        movie.overview,
                        style: grayTextFont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    // NOTE: BUTTON CONTINUE
                    Container(
                      height: 50,
                      width: 250,
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: mainColorBlue,
                          child: Text(
                            "Lanjutkan",
                            style: whiteTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToSelectSchedulePage(movieDetail));
                          }),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
