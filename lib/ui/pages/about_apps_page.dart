part of 'pages.dart';

class AboutAppsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
        backgroundColor: bgLight,
        appBar: AppBar(
          backgroundColor: bgLight,
          brightness: Brightness.light,
          leading: GestureDetector(
            onTap: () {
              context.read<PageBloc>().add(GoToProfilePage());
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Tentang Aplikasi",
            style: blackTextFont.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              //NOTE: ILLUSTRATION
              Container(
                width: 300,
                height: 300,
                margin: EdgeInsets.only(bottom: 30),
                child: Lottie.asset("assets/illustration_me.json"),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tayangin, aplikasi pembelian tiket bioskop secara online di Tangerang dan sekitarnya.",
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Coded with love by Nailul Firdaus.",
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Framework Flutter with Dart programming language and Firebase database by Google.",
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Versi 1.0.0\n${String.fromCharCode(169)}2020 - ${DateTime.now().year}. Tayangin.",
                      style: grayTextFont.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
