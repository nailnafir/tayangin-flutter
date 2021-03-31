part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

enum LanguageOption { bahasa, english }
enum ThemeOption { light, dark }

class _ProfilePageState extends State<ProfilePage> {
  LanguageOption _language = LanguageOption.bahasa;
  ThemeOption _theme = ThemeOption.light;

  @override
  Widget build(BuildContext context) {
    // modal dialog theme
    _modalBottomMenuLanguage() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (_) {
            return Container(
              height: 150,
              color: bgLight,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 6,
                    margin: EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color: mainColorSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  RadioListTile<LanguageOption>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icon_flag_indonesia.svg",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Bahasa Indonesia",
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    activeColor: mainColorSecondary,
                    value: LanguageOption.bahasa,
                    groupValue: _language,
                    onChanged: (LanguageOption value) {
                      setState(() {
                        _language = value;
                      });

                      Fluttertoast.showToast(
                        msg: "Tunggu update selanjutnya ya",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );

                      Navigator.of(context).pop();
                    },
                  ),
                  RadioListTile<LanguageOption>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icon_flag_united_kingdom.svg",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Bahasa Inggris",
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    activeColor: mainColorSecondary,
                    value: LanguageOption.english,
                    groupValue: _language,
                    onChanged: (LanguageOption value) {
                      setState(() {
                        _language = value;
                      });

                      Fluttertoast.showToast(
                        msg: "Tunggu update selanjutnya ya",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    // modal dialog theme
    _modalBottomMenuTheme() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (_) {
            return Container(
              height: 150,
              color: bgLight,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 6,
                    margin: EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color: mainColorSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  RadioListTile<ThemeOption>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icon_light_mode.svg",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Terang",
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    activeColor: mainColorSecondary,
                    value: ThemeOption.light,
                    groupValue: _theme,
                    onChanged: (ThemeOption value) {
                      setState(() {
                        _theme = value;
                      });

                      Fluttertoast.showToast(
                        msg: "Tunggu update selanjutnya ya",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );

                      Navigator.of(context).pop();
                    },
                  ),
                  RadioListTile<ThemeOption>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icon_dark_mode.svg",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Gelap",
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    activeColor: mainColorSecondary,
                    value: ThemeOption.dark,
                    groupValue: _theme,
                    onChanged: (ThemeOption value) {
                      setState(() {
                        _theme = value;
                      });

                      Fluttertoast.showToast(
                        msg: "Tunggu update selanjutnya ya",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                      );

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        return;
      },
      child: Scaffold(
        backgroundColor: bgLight,
        body: Container(
          child: ListView(
            children: <Widget>[
              BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                if (userState is UserLoaded) {
                  UserApp user = userState.user;

                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: defaultMargin),
                              padding: EdgeInsets.all(1),
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<PageBloc>()
                                      .add(GoToMainPage(bottomNavBarIndex: 0));
                                },
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Profil Saya",
                                style: blackTextFont.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 350,
                            margin: EdgeInsets.only(top: 80),
                            decoration: BoxDecoration(
                              color: mainColorPrimary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Stack(
                                children: <Widget>[
                                  //NOTE: lOADER
                                  Center(
                                    child: Shimmer.fromColors(
                                      period: Duration(seconds: 1),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100],
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.only(top: 30),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //NOTE: PHOTO PROFILE
                                  Center(
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.only(top: 30),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: (user.profilePicture != "")
                                              ? NetworkImage(
                                                  user.profilePicture)
                                              : AssetImage(
                                                  "assets/user_pic_default.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                user.name,
                                style: whiteTextFont.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                user.email,
                                style: whiteTextFont.copyWith(
                                  color: softColorPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 210),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              color: bgLight,
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: defaultMargin),
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Column(
                                children: [
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (_, userState) {
                                      //NOTE: EDIT PROFILE
                                      return GestureDetector(
                                        onTap: () {
                                          context.read<PageBloc>().add(
                                              GoToEditProfilePage(
                                                  (userState as UserLoaded)
                                                      .user));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              2 * defaultMargin,
                                          color: Colors.transparent,
                                          child: Stack(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    child: SvgPicture.asset(
                                                        "assets/icon_profile.svg"),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    "Ubah Profil",
                                                    style:
                                                        blackTextFont.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  MdiIcons.chevronRight,
                                                  color: mainColorSecondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  //NOTE: MY WALLET
                                  GestureDetector(
                                    onTap: () {
                                      context.read<PageBloc>().add(
                                          GoToWalletPage(GoToProfilePage()));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 24,
                                                height: 24,
                                                child: SvgPicture.asset(
                                                    "assets/icon_wallet_balance.svg"),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Dompet Saya",
                                                style: blackTextFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              MdiIcons.chevronRight,
                                              color: mainColorSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  //NOTE: CHANGE LANGUAGE
                                  GestureDetector(
                                    onTap: _modalBottomMenuLanguage,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 24,
                                                height: 24,
                                                child: SvgPicture.asset(
                                                    "assets/icon_translate.svg"),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Ganti Bahasa",
                                                style: blackTextFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              MdiIcons.chevronRight,
                                              color: mainColorSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  //NOTE: THEMES
                                  GestureDetector(
                                    onTap: _modalBottomMenuTheme,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 24,
                                                height: 24,
                                                child: SvgPicture.asset(
                                                    "assets/icon_theme.svg"),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Tampilan Tema",
                                                style: blackTextFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              MdiIcons.chevronRight,
                                              color: mainColorSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  //NOTE: CONTACT ME
                                  GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(contactMeURL)) {
                                        await launch(contactMeURL);
                                      } else {
                                        throw 'Gagal menjalankan $contactMeURL';
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 24,
                                                height: 24,
                                                child: SvgPicture.asset(
                                                    "assets/icon_contact_me.svg"),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Kontak Bantuan",
                                                style: blackTextFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              MdiIcons.chevronRight,
                                              color: mainColorSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  //NOTE: RATE APPS
                                  GestureDetector(
                                    onTap: () {
                                      Fluttertoast.showToast(
                                        msg: "Tunggu update selanjutnya ya",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 24,
                                                height: 24,
                                                child: SvgPicture.asset(
                                                    "assets/icon_rate_like.svg"),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Nilai Aplikasi Tayangin",
                                                style: blackTextFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              MdiIcons.chevronRight,
                                              color: mainColorSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  //NOTE: ABOUT APPS
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<PageBloc>()
                                          .add(GoToAboutAppsPage());
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 24,
                                                height: 24,
                                                child: SvgPicture.asset(
                                                    "assets/icon_about_apps.svg"),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Tentang Aplikasi Tayangin",
                                                style: blackTextFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              MdiIcons.chevronRight,
                                              color: mainColorSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  //NOTE: SIGN OUT
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    width: 250,
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 2,
                                          primary: mainColorSecondary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Text(
                                          "Keluar",
                                          style: whiteTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        onPressed: () {
                                          context
                                              .read<UserBloc>()
                                              .add(SignOut());
                                          AuthServices.signOut();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
