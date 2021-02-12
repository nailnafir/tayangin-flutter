part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;
  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 80),
                    height: 24,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToPreferencePage(
                                    widget.registrationData));
                              },
                              child: Icon(Icons.arrow_back)),
                        ),
                        Center(
                          child: Text(
                            "Konfirmasi Akun Kamu",
                            style: blackTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (widget.registrationData.profileImage == null)
                              ? AssetImage("assets/user_pic_default.png")
                              : FileImage(widget.registrationData.profileImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Text(
                    "Selamat Datang,",
                    style: blackTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${widget.registrationData.name}!",
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 80),
                  (isSigningUp)
                      ? SpinKitThreeBounce(
                          color: Color(0xFF00AB1B),
                          size: 50,
                        )
                      : SizedBox(
                          width: 250,
                          height: 50,
                          child: RaisedButton(
                            color: Color(0xFF00AB1B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "Buat Akun Saya",
                              style: whiteTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  widget.registrationData.profileImage;

                              SignInSignUpResult result =
                                  await AuthServices.signUp(
                                      widget.registrationData.email,
                                      widget.registrationData.password,
                                      widget.registrationData.name,
                                      widget.registrationData.selectedGenres,
                                      widget.registrationData.selectedLanguage);

                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });

                                Flushbar(
                                        duration: Duration(milliseconds: 3000),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: accentColorRed,
                                        message: result.message)
                                    .show(context);
                              }
                            },
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
