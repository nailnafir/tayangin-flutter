part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorBlue,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo_tayangin.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80, bottom: 18),
                child: Text(
                  "Hiburan Seru",
                  style: whiteTextFont.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "Temukan hiburanmu dengan \nmenonton banyak film tanpa ribet",
                style: whiteTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 250,
                height: 50,
                margin: EdgeInsets.only(top: 50, bottom: 20),
                child: RaisedButton(
                  child: Text("Mulai",
                      style: blackTextFont.copyWith(fontSize: 16)),
                  color: mainColorYellow,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sudah punya akun? ",
                    style: whiteTextFont.copyWith(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.bloc<PageBloc>().add(GoToLoginPage());
                    },
                    child: Text(
                      "Masuk disini",
                      style: yellowTextFont,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
