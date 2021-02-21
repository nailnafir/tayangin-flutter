part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;
  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .bloc<PageBloc>()
              .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
          return;
        },
        child: Scaffold(
          body: Center(
            child: Text(widget.ticket.bookingCode),
          ),
        ));
  }
}
