part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;
  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

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
                        Container(
                          padding: EdgeInsets.all(1),
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToSelectSchedulePage(
                                      widget.ticket.movieDetail));
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Pilih Bangku",
                            style: blackTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //NOTE: CINEMA SCREEN
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width:
                        (MediaQuery.of(context).size.width - 2 * defaultMargin),
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/screen.png")),
                    ),
                  ),
                  // NOTE: SEATS
                  generateSeats(),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        defaultMargin, 30, defaultMargin, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: accentColorDarkGray)),
                            ),
                            Text(
                              "Tersedia",
                              style: blackTextFont.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: accentColorLightGray,
                                  border:
                                      Border.all(color: accentColorLightGray)),
                            ),
                            Text(
                              "Tidak Tersedia",
                              style: blackTextFont.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: mainColorYellow,
                                  border:
                                      Border.all(color: Colors.transparent)),
                            ),
                            Text(
                              "Pilihanmu",
                              style: blackTextFont.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //NOTE: NEXT BUTTON
                  Container(
                    width: 250,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(
                        defaultMargin, 10, defaultMargin, 30),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                        color: selectedSeats.length > 0
                            ? mainColorBlue
                            : accentColorLightGray,
                        child: Text("Lanjutkan",
                            style: selectedSeats.length > 0
                                ? whiteTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500)
                                : grayTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                        onPressed: () {}),
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberOfSeats = [4, 6, 6, 6, 6, 4];
    List<Widget> widgets = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberOfSeats[i],
          (index) => Container(
            padding: EdgeInsets.only(
              right: (index < numberOfSeats[i] - 1) ? 18 : 0,
              bottom: 18,
            ),
            child: SelectableBox(
              "${String.fromCharCode(i + 65)}${index + 1}",
              width: 40,
              height: 40,
              textStyle: (index != 0 && i != 4)
                  ? blackTextFont.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400)
                  : grayTextFont.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
              isEnabled: index != 0 && i != 4,
              isSelected: selectedSeats
                  .contains("${String.fromCharCode(i + 65)}${index + 1}"),
              onTap: () {
                String seatNumber =
                    "${String.fromCharCode(i + 65)}${index + 1}";
                setState(() {
                  if (selectedSeats.contains(seatNumber)) {
                    selectedSeats.remove(seatNumber);
                  } else {
                    selectedSeats.add(seatNumber);
                  }
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
