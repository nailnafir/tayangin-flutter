part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorPrimary,
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: mainColorSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Mulai",
                      style: whiteTextFont.copyWith(fontSize: 16)),
                  onPressed: () {
                    context
                        .read<PageBloc>()
                        .add(GoToRegistrationPage(RegistrationData()));
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sudah punya akun? ",
                    style: whiteTextFont.copyWith(fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<PageBloc>().add(GoToLoginPage());
                    },
                    child: Text(
                      "Masuk disini",
                      style: secondaryColorTextFont.copyWith(
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
