part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: mainColorBlue),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: <Widget>[
                //NOTE: BACK ICON
                Container(
                  margin: EdgeInsets.only(top: 16, left: defaultMargin),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMovieDetailPage(widget.movieDetail));
                            return;
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Kedatanganmu",
                          style: blackTextFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                //NOTE: CHOOSE DATE
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
                  child: Text(
                    "Pilih Tanggal",
                    style: blackTextFont.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (_, index) => Container(
                            margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                              right: (index < dates.length - 1)
                                  ? 18
                                  : defaultMargin,
                            ),
                            child: DateCard(
                              dates[index],
                              isSelected: selectedDate == dates[index],
                              onTap: () {
                                setState(() {
                                  selectedDate = dates[index];
                                });
                              },
                            ),
                          )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
