part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToTicketPage(ticket));
          return;
        },
        child: Scaffold(
          body: Center(
            child: Text(ticket.movieDetail.title),
          ),
        ));
  }
}
