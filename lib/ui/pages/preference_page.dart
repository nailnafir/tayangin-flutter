part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Action",
    "Comedy",
    "Drama",
    "Horror",
    "Music",
    "War",
  ];

  final List<String> languages = [
    "Bahasa",
    "English",
    "Japanese",
    "Korean",
  ];

  final RegistrationData registrationData;
  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  // untuk mencatat, list mana yang sudah dipilih
  List<String> selectedGenres = [];

  // untuk select default pilihan bahasa film ke Inggris
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";

        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 30),
                    height: 24,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              widget.registrationData.password = "";

                              context.bloc<PageBloc>().add(GoToRegistrationPage(
                                  widget.registrationData));
                              return;
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Kesukaan Kamu",
                            style: blackTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Pilih Kategori\nYang Kamu Suka",
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  SizedBox(height: 18),
                  Wrap(
                    spacing: 24, // jarak horizontal
                    runSpacing: 24, // jarak vertikal
                    children: generateGenreWidgets(context),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Kamu Suka Film\nBahasa Apa?",
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  SizedBox(height: 18),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLanguageWidgets(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    // bagi ukuran widget dengan layar
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    // masing-masing element dibuatkan selectable box nya
    return widget.genres
        .map((e) => SelectableBox(
              // elemen dari widget genre nya, list of string
              e,

              // lebar nya sesuai yang diatas tadi
              width: width,

              // kalau di dalam selected genre ini ada elemen yang nilainya sama dengan e
              // kalau ternyata di selected genre ada action, actionnya itu true, nyala.
              isSelected: selectedGenres.contains(e),

              // yang ditap, jadi elemen genre yang dipilih biar nyala ataupun biar mati
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();
  }

  List<Widget> generateLanguageWidgets(BuildContext context) {
    // bagi ukuran widget dengan layar
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => SelectableBox(
              // elemen dari widget language nya, list of string
              e,

              // lebar nya sesuai yang diatas tadi
              width: width,

              // true kalau sama dengan elemen, karena cuma bisa pilih satu
              isSelected: selectedLanguage == e,

              // kalo ditap, langsung nyala ke yang ditap, cuma bisa pilih satu
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    // jika di dalam selected genre ternyata sudah ada genrenya yang ditap, bererti dihapus
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });

      // ternyata belum dipilih
    } else {
      // maksimal 4
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
