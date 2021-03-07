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

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
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
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: "Email Address"),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 6;
                        });
                      },
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
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToForgotPasswordPage());
                          },
                          child: Text("Reset disini",
                              style: yellowTextFont.copyWith(
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        height: 50,
                        margin: EdgeInsets.only(top: 50, bottom: 12),
                        child: isSigningIn
                            ? SpinKitFadingCircle(color: mainColorBlue)
                            : FloatingActionButton(
                                child: Text("Masuk",
                                    style: isEmailValid && isPasswordValid
                                        ? whiteTextFont.copyWith(fontSize: 16)
                                        : grayTextFont.copyWith(fontSize: 16)),
                                backgroundColor: isEmailValid && isPasswordValid
                                    ? mainColorBlue
                                    : accentColorLightGray,
                                elevation: 2,
                                onPressed: isEmailValid && isPasswordValid
                                    ? () async {
                                        // ubah state jadi true
                                        setState(() {
                                          isSigningIn = true;
                                        });

                                        // tampung dan berikan result dari inputan text
                                        SignInSignUpResult result =
                                            await AuthServices.signIn(
                                                emailController.text,
                                                passwordController.text);

                                        // ubah state lagi jadi false jika hasilnya keluar
                                        if (result.user == null) {
                                          setState(() {
                                            isSigningIn = false;
                                          });

                                          // berikan pesan
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 3000),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: accentColorRed,
                                            message: result.message,
                                          ).show(context);
                                        }
                                      }
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Belum punya akun? ",
                          style: grayTextFont.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToRegistrationPage(RegistrationData()));
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
      ),
    );
  }
}
