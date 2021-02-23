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
          body: Stack(children: <Widget>[
            Container(color: mainColorBlue),
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    //NOTE: HEADER
                    Container(
                      margin: EdgeInsets.only(top: 16, left: defaultMargin),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {},
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Pilih Bangku",
                              style: blackTextFont.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
        ));
  }
}
