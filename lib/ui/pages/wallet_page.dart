part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) {
                      return Column(
                        children: <Widget>[
                          //NOTE: ICON BACK
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(1),
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                      onTap: () {
                                        context.bloc<PageBloc>().add(pageEvent);
                                      },
                                      child: Icon(Icons.arrow_back,
                                          color: Colors.black)),
                                ),
                                Center(
                                  child: Text(
                                    'Dompet Saya',
                                    style: blackTextFont.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //NOTE: CARD
                          Container(
                            height: 180,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: mainColorBlue,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.0, 3.0))
                              ],
                            ),
                            child: Stack(
                              children: <Widget>[
                                ClipPath(
                                  clipper: CardReflectionClipper(),
                                  child: Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.white.withOpacity(0.1),
                                            Colors.white.withOpacity(0.1),
                                          ]),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: accentColorYellow,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: mainColorYellow,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id_ID',
                                                decimalDigits: 0,
                                                symbol: 'IDR ')
                                            .format((userState as UserLoaded)
                                                .user
                                                .balance),
                                        style: yellowNumberFont.copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Pemilik Kartu',
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white54,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    (userState as UserLoaded)
                                                        .user
                                                        .name,
                                                    style:
                                                        whiteTextFont.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    "assets/icon_verified.png",
                                                    width: 14,
                                                    height: 14,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 30),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'ID Kartu',
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white54,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    (userState as UserLoaded)
                                                        .user
                                                        .id
                                                        .substring(0, 12)
                                                        .toUpperCase(),
                                                    style:
                                                        whiteTextFont.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Image.asset(
                                                    "assets/icon_verified.png",
                                                    width: 14,
                                                    height: 14,
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
