part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final TayanginTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return;
      },
      child: Scaffold(
        backgroundColor: bgLight,
        body: FutureBuilder(
          // jika ada tiketnya, berarti lagi beli tiket, kalo gak ada ya topup
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(context),
          builder: (_, snapshot) =>
              (snapshot.connectionState == ConnectionState.done)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 250,
                          height: 250,
                          margin: EdgeInsets.only(bottom: 80),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ticket == null
                                      ? "assets/illustration_success_top_up.png"
                                      : "assets/illustration_success_buy.png"))),
                        ),
                        Text(
                          ticket == null
                              ? "Hmmm, Syukurlah!"
                              : "Yuhuuu, Nonton Film!",
                          style: blackTextFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 18),
                        Text(
                          ticket == null
                              ? "Sekarang saldo kamu\nbertambah banyak"
                              : "Kamu telah berhasil\nmembeli tiket bioskop",
                          style: grayTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          margin: EdgeInsets.only(top: 50, bottom: 12),
                          child: RaisedButton(
                            elevation: 2,
                            color: mainColorPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              ticket == null ? "Dompet Saya" : "Tiket Saya",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {
                              if (ticket == null) {
                                context.bloc<PageBloc>().add(GoToWalletPage(
                                    GoToMainPage(bottomNavBarIndex: 0)));
                              } else {
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToMainPage(bottomNavBarIndex: 1));
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Mau nonton film lagi? ",
                                style: grayTextFont.copyWith(
                                    fontWeight: FontWeight.w400)),
                            GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToMainPage());
                              },
                              child: Text("Yuk lah!",
                                  style: secondaryColorTextFont.copyWith(
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: SpinKitFadingCircle(
                        size: 100,
                        color: mainColorPrimary,
                      ),
                    ),
        ),
      ),
    );
  }

  // perlu build context untuk memanggil event dari dua bloc
  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userID));

    await TayanginTransactionServices.saveTransaction(transaction);
  }

  // perlu build context untuk memanggil event bloc
  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));

    await TayanginTransactionServices.saveTransaction(transaction);
  }
}
