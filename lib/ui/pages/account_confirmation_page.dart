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
            .read<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
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
                  .add(GoToPreferencePage(widget.registrationData));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Konfirmasi Akun",
            style: blackTextFont.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.symmetric(vertical: 30),
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
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF00AB1B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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

                              Fluttertoast.showToast(
                                msg: "Berhasil Daftar",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );

                              print(result.message ?? "SIGN UP STATUS: OK");

                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });

                                Flushbar(
                                        icon: Icon(MdiIcons.closeCircleOutline,
                                            color: Colors.white),
                                        duration: Duration(milliseconds: 3000),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        backgroundColor: mainColorSecondary,
                                        message: result.message)
                                    .show(context);
                              }
                            },
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
