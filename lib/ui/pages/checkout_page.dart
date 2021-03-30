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
    int total = 26500 * widget.ticket.seats.length;

    return WillPopScope(
        onWillPop: () async {
          context.read<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
          return;
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(color: mainColorPrimary),
              SafeArea(child: Container(color: bgLight)),
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
                                      .read<PageBloc>()
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
                                Stack(
                                  children: [
                                    Shimmer.fromColors(
                                      period: Duration(seconds: 1),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100],
                                      child: Container(
                                        width: 80,
                                        height: 100,
                                        margin: EdgeInsets.only(
                                            left: defaultMargin, right: 18),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 100,
                                      margin: EdgeInsets.only(
                                          left: defaultMargin, right: 18),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: NetworkImage(imageBaseURL +
                                                  "w342" +
                                                  widget.ticket.movieDetail
                                                      .posterPath),
                                              fit: BoxFit.cover)),
                                    ),
                                  ],
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
                              padding: EdgeInsets.symmetric(
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
                              padding: EdgeInsets.symmetric(
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
                              padding: EdgeInsets.symmetric(
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Nomor Kursi",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        120,
                                    child: Text(widget.ticket.seatsInString,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Harga",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                      "IDR 25.000 x ${widget.ticket.seats.length}",
                                      style: blackNumberFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Biaya Layanan",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                      "IDR 1.500 x ${widget.ticket.seats.length}",
                                      style: blackNumberFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Total Bayar",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                      NumberFormat.currency(
                                              locale: 'id_ID',
                                              decimalDigits: 0,
                                              symbol: 'IDR ')
                                          .format(total),
                                      style: blackNumberFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Saldo Kamu",
                                      style: grayTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                      NumberFormat.currency(
                                              locale: 'id_ID',
                                              decimalDigits: 0,
                                              symbol: 'IDR ')
                                          .format(user.balance),
                                      style: (user.balance >= total)
                                          ? greenNumberFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)
                                          : redNumberFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 30),
                              width: 250,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    primary: user.balance >= total
                                        ? accentColorGreen
                                        : mainColorPrimary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text(
                                    user.balance >= total
                                        ? "Bayar Sekarang"
                                        : "Isi Saldo",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () {
                                    if (user.balance >= total) {
                                      TayanginTransaction transaction =
                                          TayanginTransaction(
                                              userID: user.id,
                                              title: widget
                                                  .ticket.movieDetail.title,
                                              subtitle:
                                                  widget.ticket.theater.name,
                                              time: DateTime.now(),
                                              amount: -total,
                                              picture: widget.ticket.movieDetail
                                                  .posterPath);

                                      context.read<PageBloc>().add(
                                          GoToSuccessPage(
                                              widget.ticket
                                                  .copyWith(totalPrice: total),
                                              transaction));
                                    } else {
                                      context.read<PageBloc>().add(
                                          GoToTopUpPage(
                                              GoToCheckoutPage(widget.ticket)));
                                    }
                                  }),
                            )
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
