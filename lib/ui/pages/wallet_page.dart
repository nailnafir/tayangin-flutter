part of 'pages.dart';

class WalletPage extends StatefulWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: bgLight,
        appBar: AppBar(
          backgroundColor: bgLight,
          brightness: Brightness.light,
          leading: GestureDetector(
            onTap: () {
              context.read<PageBloc>().add(widget.pageEvent);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Dompet Saya",
            style: blackTextFont.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  return RefreshIndicator(
                    color: mainColorSecondary,
                    onRefresh: () async {
                      await Future.delayed(new Duration(seconds: 1));
                      setState(() {});
                    },
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Column(
                            children: <Widget>[
                              //NOTE: CARD
                              Container(
                                height: 180,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: mainColorPrimary,
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                    Container(
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
                                                  color: hardColorSecondary,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: mainColorSecondary,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            NumberFormat.currency(
                                                    locale: 'id_ID',
                                                    decimalDigits: 0,
                                                    symbol: 'IDR ')
                                                .format(
                                                    (userState as UserLoaded)
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
                                                    style:
                                                        whiteTextFont.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white54,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        (userState
                                                                as UserLoaded)
                                                            .user
                                                            .name,
                                                        style: whiteTextFont
                                                            .copyWith(
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
                                                    style:
                                                        whiteTextFont.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white54,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        (userState
                                                                as UserLoaded)
                                                            .user
                                                            .id
                                                            .substring(0, 12)
                                                            .toUpperCase(),
                                                        style: whiteTextFont
                                                            .copyWith(
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
                              ),
                              //NOTE: TRANSACTION HISTORY
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  "Transaksi Terakhir",
                                  style: blackTextFont.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                  future: TayanginTransactionServices
                                      .getTransaction(
                                          (userState as UserLoaded).user.id),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return generateTransactionList(
                                        snapshot.data,
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin,
                                      );
                                    } else {
                                      return SpinKitThreeBounce(
                                        size: 50,
                                        color: mainColorPrimary,
                                      );
                                    }
                                  }),
                              SizedBox(height: 70),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              //NOTE: BUTTON
              Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 250,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: mainColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Isi Saldo",
                          style: whiteTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          context.read<PageBloc>().add(
                              GoToTopUpPage(GoToWalletPage(GoToProfilePage())));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column generateTransactionList(
      List<TayanginTransaction> transactions, double width) {
    transactions.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));

    if (transactions.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EmptyList(
            title: "Waduh, Transaksi Kosong!",
            assetPath: "assets/illustration_empty_list.json",
            width: 300,
            height: 300,
          ),
        ],
      );
    } else {
      return Column(
        children: transactions
            .map((transaction) => Container(
                padding: EdgeInsets.only(bottom: 18),
                child: TransactionCard(transaction, width)))
            .toList(),
      );
    }
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
