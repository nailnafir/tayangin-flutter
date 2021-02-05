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
                    width: 96,
                    height: 110,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: (widget.registrationData.profileImage ==
                                      null)
                                  ? AssetImage("assets/user_pic_default.png")
                                  : FileImage(
                                      widget.registrationData.profileImage),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              // TODO: Ambil foto dari galeri
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
                  SizedBox(height: 35),
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Password"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: retypePasswordController,
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
                        onPressed: () {},
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
