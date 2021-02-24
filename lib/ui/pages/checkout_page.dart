part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;
  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
          return;
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(color: mainColorBlue),
              SafeArea(child: Container(color: Colors.white)),
              ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      //NOTE: BACK BUTTON
                      Row(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: 16, left: defaultMargin),
                            padding: EdgeInsets.all(1),
                            child: GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToSelectSeatPage(widget.ticket));
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                        UserApp user = (userState as UserLoaded).user;
                        return Column(
                          children: <Widget>[
                            //NOTE: PAGE TITLE
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 16, bottom: 30),
                                child: Text(
                                  "Detail Pembelian",
                                  style: blackTextFont.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            //NOTE: MOVIE DESCRIPTION
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 100,
                                  margin: EdgeInsets.only(
                                      left: defaultMargin, right: 18),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseURL +
                                              "w342" +
                                              widget.ticket.movieDetail
                                                  .posterPath),
                                          fit: BoxFit.cover)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          80 -
                                          18,
                                      child: Text(
                                        widget.ticket.movieDetail.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: blackTextFont.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          80 -
                                          18,
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      child: Text(
                                        widget.ticket.movieDetail
                                            .genresAndLanguage,
                                        style: grayTextFont.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    RatingStars(
                                      voteAverage:
                                          widget.ticket.movieDetail.voteAverage,
                                      color: accentColorDarkGray,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 30),
                              child: Divider(
                                color: accentColorLightGray,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("ID Pembelian",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text(widget.ticket.bookingCode,
                                      style: blackTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Bioskop",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        120,
                                    child: Text(widget.ticket.theater.name,
                                        textAlign: TextAlign.end,
                                        style: blackTextFont.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Tanggal & Waktu",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text(widget.ticket.time.dateAndTime,
                                      style: blackTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      }),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
