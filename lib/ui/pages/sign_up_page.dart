part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final bool isPasswordVisible;
  final RegistrationData registrationData;

  SignUpPage(this.registrationData, {this.isPasswordVisible = false});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  bool isPasswordVisible;

  @override
  void initState() {
    super.initState();

    isPasswordVisible = false;

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColorPrimary)));

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToGetStartedPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: bgLight,
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
                              context
                                  .read<PageBloc>()
                                  .add(GoToGetStartedPage());
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
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Nama Lengkap"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Email"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible
                              ? MdiIcons.eye
                              : MdiIcons.eyeOff),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        labelText: "Password"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: retypePasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible
                              ? MdiIcons.eye
                              : MdiIcons.eyeOff),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
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
                                    icon: Icon(MdiIcons.closeCircleOutline,
                                        color: Colors.white),
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: mainColorSecondary,
                                    message: "Harap isi semua data")
                                .show(context);
                          } else if (passwordController.text !=
                              retypePasswordController.text) {
                            Flushbar(
                                    icon: Icon(MdiIcons.closeCircleOutline,
                                        color: Colors.white),
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: mainColorSecondary,
                                    message:
                                        "Password yang dimasukkan tidak sama")
                                .show(context);
                          } else if (passwordController.text.length < 6) {
                            Flushbar(
                                    icon: Icon(MdiIcons.closeCircleOutline,
                                        color: Colors.white),
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: mainColorSecondary,
                                    message: "Minimal password 6 karakter")
                                .show(context);
                          } else if (!EmailValidator.validate(
                              emailController.text)) {
                            Flushbar(
                                    icon: Icon(MdiIcons.closeCircleOutline,
                                        color: Colors.white),
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: mainColorSecondary,
                                    message:
                                        "Email yang dimasukkan bukan format email")
                                .show(context);
                          } else if (widget.registrationData.profileImage ==
                              null) {
                            Flushbar(
                                    icon: Icon(MdiIcons.closeCircleOutline,
                                        color: Colors.white),
                                    duration: Duration(milliseconds: 3000),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: mainColorSecondary,
                                    message: "Foto tidak boleh kosong")
                                .show(context);
                          } else {
                            widget.registrationData.name = nameController.text;
                            widget.registrationData.email =
                                emailController.text;
                            widget.registrationData.password =
                                passwordController.text;

                            context.read<PageBloc>().add(
                                GoToPreferencePage(widget.registrationData));
                          }
                        },
                        backgroundColor: mainColorPrimary,
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
