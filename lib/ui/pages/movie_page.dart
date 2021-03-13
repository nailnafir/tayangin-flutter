part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // deklarasi firebase user
    auth.User firebaseUser = Provider.of<auth.User>(context);

    // deklarasi ucapan salam
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 9) {
        return 'Pagi';
      } else if (hour < 14) {
        return 'Siang';
      } else if (hour < 18) {
        return 'Sore';
      } else {
        return 'Malam';
      }
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: mainColorBlue),
          SafeArea(
            child: Container(
              color: Colors.white,
              child: RefreshIndicator(
                color: mainColorBlue,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
                  context.bloc<MovieBloc>().add(FetchMovies());
                },
                child: ListView(
                  children: <Widget>[
                    //NOTE: HEADER
                    GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToProfilePage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainColorBlue,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.0, 3.0))
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            defaultMargin, 28, defaultMargin, 28),
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) {
                            if (userState is UserLoaded) {
                              if (imageFileToUpload != null) {
                                uploadImage(imageFileToUpload)
                                    .then((downloadURL) {
                                  imageFileToUpload = null;
                                  context.bloc<UserBloc>().add(
                                      UpdateData(profileImage: downloadURL));
                                });
                              }
                              return Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Selamat " + greeting() + ",",
                                          style: whiteTextFont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(
                                        // ukuran layar - 2defaultMargin - 2jarak foto - 2ukuran lingkaran - jarak foto dengan tulisan
                                        width:
                                            MediaQuery.of(context).size.width -
                                                2 * defaultMargin -
                                                78,
                                        child: Text(userState.user.name + "!",
                                            style: whiteTextFont.copyWith(
                                                fontSize: 18),
                                            maxLines: 1,
                                            overflow: TextOverflow.clip),
                                      ),
                                      Text(
                                          NumberFormat.currency(
                                                  locale: "id_ID",
                                                  decimalDigits: 0,
                                                  symbol: "IDR ")
                                              .format(userState.user.balance),
                                          style: yellowNumberFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 1),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        SpinKitFadingCircle(
                                            color: mainColorYellow, size: 50),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: (userState
                                                          .user.profilePicture ==
                                                      ""
                                                  ? AssetImage(
                                                      "assets/user_pic_default.png")
                                                  : NetworkImage(userState
                                                      .user.profilePicture)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return SpinKitThreeBounce(
                                color: mainColorYellow,
                                size: 50,
                              );
                            }
                          },
                        ),
                      ),
                    ),

                    // note: SEDANG TAYANG
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 30, defaultMargin, 12),
                      child: Text("Sedang Tayang",
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: 140,
                      child: BlocBuilder<MovieBloc, MovieState>(
                          builder: (_, movieState) {
                        if (movieState is MovieLoaded) {
                          List<Movie> movies = movieState.movies.sublist(0, 10);
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (_, index) => Container(
                              margin: EdgeInsets.only(
                                  left: (index == 0) ? defaultMargin : 0,
                                  right: (index == movies.length - 1)
                                      ? defaultMargin
                                      : 18),
                              child: MovieCard(
                                movies[index],
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToMovieDetailPage(movies[index]));
                                },
                              ),
                            ),
                          );
                        } else {
                          return SpinKitThreeBounce(
                            color: mainColorBlue,
                            size: 50,
                          );
                        }
                      }),
                    ),

                    //NOTE: KATEGORI FILM
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 30, defaultMargin, 12),
                      child: Text(
                        "Kategori Film",
                        style: blackTextFont.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                      if (userState is UserLoaded) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                userState.user.selectedGenres.length,
                                (index) => BrowseButton(
                                    userState.user.selectedGenres[index])),
                          ),
                        );
                      } else {
                        return SpinKitThreeBounce(
                          color: mainColorBlue,
                          size: 50,
                        );
                      }
                    }),

                    // NOTE: SEGERA TAYANG
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 30, defaultMargin, 12),
                      child: Text("Segera Tayang",
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: 200,
                      child: BlocBuilder<MovieBloc, MovieState>(
                          builder: (_, movieState) {
                        if (movieState is MovieLoaded) {
                          List<Movie> movies = movieState.movies.sublist(10);
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            itemBuilder: (_, index) => Container(
                              margin: EdgeInsets.only(
                                  left: (index == 0) ? defaultMargin : 0,
                                  right: (index == movies.length - 1)
                                      ? defaultMargin
                                      : 18),
                              child: ComingSoonCard(movies[index]),
                            ),
                          );
                        } else {
                          return SpinKitThreeBounce(
                            color: mainColorBlue,
                            size: 50,
                          );
                        }
                      }),
                    ),

                    // NOTE: PROMO
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 30, defaultMargin, 12),
                      child: Text("Promo Untukmu",
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    Column(
                      children: dummyPromo
                          .map((e) => Padding(
                              padding: EdgeInsets.fromLTRB(
                                  defaultMargin, 0, defaultMargin, 18),
                              child: PromoCard(e)))
                          .toList(),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
