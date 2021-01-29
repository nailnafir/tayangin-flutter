part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColorYellow)));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50),
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset("assets/logo_tayangin_blue.png")),
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 30),
                    child: Text(
                      "Selamat datang,\nTayangquwh!",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Email Address"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Password"),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Text("Lupa password? ",
                          style: grayTextFont.copyWith(
                              fontWeight: FontWeight.w400)),
                      Text("Reset disini",
                          style: yellowTextFont.copyWith(
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      height: 50,
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: RaisedButton(
                          child: Text("Masuk",
                              style: whiteTextFont.copyWith(fontSize: 16)),
                          color: mainColorBlue,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Belum punya akun? ",
                        style:
                            grayTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToLoginPage());
                        },
                        child: Text(
                          "Buat disini",
                          style: yellowTextFont.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
