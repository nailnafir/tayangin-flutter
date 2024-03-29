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
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

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
        context.read<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: Scaffold(
        backgroundColor: bgLight,
        appBar: AppBar(
          backgroundColor: bgLight,
          brightness: Brightness.light,
          leading: GestureDetector(
            onTap: () {
              context
                  .read<PageBloc>()
                  .add(GoToMovieDetailPage(widget.movieDetail));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Kedatanganmu",
            style: blackTextFont.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              //NOTE: CHOOSE DATE
              Container(
                margin:
                    EdgeInsets.fromLTRB(defaultMargin, 24, defaultMargin, 12),
                child: Text(
                  "Pilih Tanggal",
                  style: blackTextFont.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: defaultMargin),
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index < dates.length - 1) ? 18 : defaultMargin,
                    ),
                    child: DateCard(
                      dates[index],
                      isSelected: selectedDate == dates[index],
                      onTap: () {
                        setState(() {
                          selectedDate = dates[index];
                          isValid = false;
                          selectedTheater = null;
                          selectedTime = null;
                        });
                      },
                    ),
                  ),
                ),
              ),
              //NOTE: CHOOSE TIME & LOCATION
              generateTimeTable(),
              //NOTE: BUTTON NEXT
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 50,
                  width: 250,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 10, defaultMargin, 30),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) => FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor:
                            (isValid) ? mainColorPrimary : accentColorLightGray,
                        elevation: 2,
                        child: Text(
                          "Lanjutkan",
                          style: isValid
                              ? whiteTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0)
                              : grayTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0),
                        ),
                        onPressed: () {
                          if (isValid) {
                            context
                                .read<PageBloc>()
                                .add(GoToSelectSeatPage(Ticket(
                                  widget.movieDetail,
                                  selectedTheater,
                                  DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime),
                                  randomAlphaNumeric(12).toUpperCase(),
                                  null,
                                  (userState as UserLoaded).user.name,
                                  null,
                                )));
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      widgets.add(Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 12),
        child: Text(theater.name,
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.w500)),
      ));

      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: defaultMargin),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
              left: (index == 0) ? defaultMargin : 0,
              right: (index == schedule.length - 1) ? defaultMargin : 18,
            ),
            child: SelectableBox(
              "${schedule[index]}:00",
              textStyle: (schedule[index] > DateTime.now().hour ||
                      selectedDate.day != DateTime.now().day)
                  ? blackTextFont.copyWith(fontSize: 14)
                  : grayTextFont.copyWith(fontSize: 14),
              height: 50,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate.day != DateTime.now().day,
              onTap: !(schedule[index] > DateTime.now().hour ||
                      selectedDate.day != DateTime.now().day)
                  ? null
                  : () {
                      setState(() {
                        selectedTheater = theater;
                        selectedTime = schedule[index];
                        isValid = true;
                      });
                    },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
