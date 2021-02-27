part of 'pages.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //NOTE: CONTENT
          BlocBuilder<TicketBloc, TicketState>(
            builder: (_, ticketState) => Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TicketViewer(isExpiredTickets
                  ? ticketState.tickets
                      .where((ticket) => ticket.time.isBefore(DateTime.now()))
                      .toList()
                  : ticketState.tickets
                      .where((ticket) => !ticket.time.isBefore(DateTime.now()))
                      .toList()),
            ),
          ),
          //NOTE: HEADER
          Container(height: 120, color: mainColorBlue),
          SafeArea(
            child: ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 120,
                color: mainColorBlue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Text(
                        "Tiket Saya",
                        style: whiteTextFont.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = !isExpiredTickets;
                                });
                              },
                              child: Text(
                                "Belum Tayang",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isExpiredTickets
                                      ? Colors.white
                                      : accentColorBlue2,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: isExpiredTickets
                                  ? mainColorYellow
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = !isExpiredTickets;
                                });
                              },
                              child: Text(
                                "Sudah Tayang",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: !isExpiredTickets
                                      ? Colors.white
                                      : accentColorBlue2,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: !isExpiredTickets
                                  ? mainColorYellow
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(0, size.height, 30, size.height);
    path.lineTo(size.width - 30, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);

  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));

    return ListView.builder(
      itemCount: sortedTickets.length,
      itemBuilder: (_, index) => Container(
        margin: EdgeInsets.only(top: index == 0 ? 130 : 18),
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageBaseURL +
                      'w500' +
                      sortedTickets[index].movieDetail.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(),
          ],
        ),
      ),
    );
  }
}
