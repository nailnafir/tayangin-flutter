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
        body: FutureBuilder(
            // jika ada tiketnya, berarti lagi beli tiket, kalo gak ada ya topup
            future: ticket != null
                ? processingTicketOrder(context)
                : processingTopUp(),
            builder: (_, snapshot) =>
                (snapshot.connectionState == ConnectionState.done)
                    ? Center(
                        child: RaisedButton(onPressed: () {
                          context.bloc<PageBloc>().add(GoToMainPage());
                        }),
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
