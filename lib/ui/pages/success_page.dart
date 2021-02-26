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
        backgroundColor: Colors.white,
        body: FutureBuilder(
            // jika ada tiketnya, berarti lagi beli tiket, kalo gak ada ya topup
            future: ticket != null
                ? processingTicketOrder(context)
                : processingTopUp(),
            builder: (_, snapshot) =>
                (snapshot.connectionState == ConnectionState.done)
                    ? Column(
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 250,
                            margin: EdgeInsets.only(bottom: 80),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: provider.Svg(ticket == null
                                        ? "assets/illustration_success_top_up.svg"
                                        : "assets/illustration_success_buy.svg"))),
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
                          Container()
                        ],
                      )
                    : Center(
                        child: SpinKitFadingCircle(
                          size: 100,
                          color: mainColorBlue,
                        ),
                      )),
      ),
    );
  }

  // perlu build context untuk memanggil event dari dua bloc
  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(ticket, transaction.userID));

    await TayanginTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp() async {}
}
