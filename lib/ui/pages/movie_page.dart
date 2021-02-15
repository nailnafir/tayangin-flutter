part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        //? HEADER
        Container(
          decoration: BoxDecoration(
            color: mainColorBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          padding: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 26),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload).then((downloadURL) {
                    imageFileToUpload = null;
                    context
                        .bloc<UserBloc>()
                        .add(UpdateData(profileImage: downloadURL));
                  });
                }
                return Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          // ukuran layar - 2defaultMargin - 2jarak foto - 2ukuran lingkaran - jarak foto dengan tulisan
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78,
                          child: Text(userState.user.name,
                              style: whiteTextFont.copyWith(fontSize: 18),
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
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Stack(
                        children: <Widget>[
                          SpinKitFadingCircle(color: mainColorYellow, size: 50),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: (userState.user.profilePicture == ""
                                    ? AssetImage("assets/user_pic_default.png")
                                    : NetworkImage(
                                        userState.user.profilePicture)),
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
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text("Sedang Tayang",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
            if (movieState is MovieLoaded) {
              List<Movie> movies = movieState.movies.sublist(0, 10);
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, index) => Container(
                  margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index == movies.length - 1) ? defaultMargin : 18),
                  child: MovieCard(movies[index]),
                ),
              );
            } else {
              return SpinKitThreeBounce(
                color: mainColorBlue,
                size: 50,
              );
            }
          }),
        )
      ],
    );
  }
}
