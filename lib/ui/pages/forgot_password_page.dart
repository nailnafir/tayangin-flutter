part of 'pages.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToLoginPage());
        return;
      },
      child: Scaffold(
        backgroundColor: bgLight,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //NOTE: HEADER
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 30),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToLoginPage());
                            },
                            child: Container(
                              padding: EdgeInsets.all(1),
                              alignment: Alignment.centerLeft,
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Lupa Password",
                              style: blackTextFont.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //NOTE: INPUT TEXT
                    Text(
                      "Ikuti petunjuk ini:",
                      style: blackTextFont.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 30),
                      width:
                          MediaQuery.of(context).size.width - 2 * defaultMargin,
                      child: generateTutorial(context),
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isEmailValid =
                              EmailValidator.validate(emailController.text);
                        });
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Email",
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        height: 50,
                        margin: EdgeInsets.only(top: 30, bottom: 12),
                        child: FloatingActionButton(
                          elevation: 2,
                          backgroundColor: (isEmailValid)
                              ? mainColorPrimary
                              : accentColorLightGray,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Reset Password",
                            style: (isEmailValid)
                                ? whiteTextFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                  )
                                : grayTextFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                  ),
                          ),
                          onPressed: (isEmailValid)
                              ? () async {
                                  await AuthServices.resetPassword(
                                      emailController.text);

                                  Flushbar(
                                    icon: Icon(MdiIcons.checkCircleOutline,
                                        color: Colors.white),
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: mainColorSecondary,
                                    message:
                                        "Kami sudah mengirimkan link untuk reset password ke email kamu",
                                  ).show(context);
                                }
                              : null,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Nanti kalo udah berhasil direset, diinget ya!\nAwas aja kalo lupa lagi!",
                        style: blackTextFont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: mainColorSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column generateTutorial(BuildContext context) {
    int number = 1;
    List<Widget> widgets = [];

    for (var tutor in dummyTutorial) {
      widgets.add(Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${number++}. ",
                style: blackNumberFont.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start),
            Container(
              width: MediaQuery.of(context).size.width - 3 * defaultMargin,
              child: Text(
                tutor.tutorial,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: blackTextFont.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
