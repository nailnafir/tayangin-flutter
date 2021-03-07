part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColorYellow)));

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
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
                    margin: EdgeInsets.only(top: 16, bottom: 30),
                    height: 24,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Buat Akun Baru",
                            style: blackTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 114,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (widget.registrationData.profileImage ==
                                        null)
                                    ? AssetImage("assets/user_pic_default.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profileImage ==
                                  null) {
                                widget.registrationData.profileImage =
                                    await getImage();
                              } else {
                                widget.registrationData.profileImage = null;
                              }

                              setState(() {});
                            },
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: provider.Svg(
                                      (widget.registrationData.profileImage ==
                                              null)
                                          ? "assets/button_add_photo.svg"
                                          : "assets/button_remove_photo.svg"),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Nama Lengkap"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Email"),
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
                  SizedBox(height: 20),
                  TextField(
                    controller: retypePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Ketik Ulang Password"),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: 250,
                      height: 50,
                      child: FloatingActionButton(
                        child: Text("Lanjutkan",
                            style: whiteTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        onPressed: () {
                          if (!(nameController.text.trim() != "" &&
                              emailController.text.trim() != "" &&
                              passwordController.text.trim() != "" &&
                              retypePasswordController.text.trim() != "")) {
                            Flushbar(
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: accentColorRed,
                                    message: "Harap isi semua data")
                                .show(context);
                          } else if (passwordController.text !=
                              retypePasswordController.text) {
                            Flushbar(
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: accentColorRed,
                                    message:
                                        "Password yang dimasukkan tidak sama")
                                .show(context);
                          } else if (passwordController.text.length < 6) {
                            Flushbar(
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: accentColorRed,
                                    message: "Minimal password 6 karakter")
                                .show(context);
                          } else if (!EmailValidator.validate(
                              emailController.text)) {
                            Flushbar(
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: accentColorRed,
                                    message:
                                        "Email yang dimasukkan bukan format email")
                                .show(context);
                          } else if (widget.registrationData.profileImage ==
                              null) {
                            Flushbar(
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: accentColorRed,
                                    message: "Foto tidak boleh kosong")
                                .show(context);
                          } else {
                            widget.registrationData.name = nameController.text;
                            widget.registrationData.email =
                                emailController.text;
                            widget.registrationData.password =
                                passwordController.text;

                            context.bloc<PageBloc>().add(
                                GoToPreferencePage(widget.registrationData));
                          }
                        },
                        backgroundColor: mainColorBlue,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
