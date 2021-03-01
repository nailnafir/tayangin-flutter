part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                if (userState is UserLoaded) {
                  UserApp user = userState.user;

                  return Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          //NOTE: HEADER
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
                                      context.bloc<PageBloc>().add(
                                          GoToMainPage(bottomNavBarIndex: 0));
                                    },
                                    child: Icon(Icons.arrow_back,
                                        color: Colors.black),
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
                          //NOTE: PHOTO PROFILE
                          Container(
                            height: 350,
                            margin: EdgeInsets.only(top: 120),
                            decoration: BoxDecoration(
                              color: mainColorBlue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Center(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(top: 70),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: (user.profilePicture != "")
                                          ? NetworkImage(user.profilePicture)
                                          : AssetImage(
                                              "assets/user_pic_default.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
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
                                  color: accentColorBlue2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 350,
                            margin: EdgeInsets.only(top: 250),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: defaultMargin),
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                            "assets/icon_profile.svg"),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Ubah Profil",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                            "assets/icon_wallet_balance.svg"),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Dompet Saya",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                            "assets/icon_translate.svg"),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Ganti Bahasa",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                            "assets/icon_rate_like.svg"),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Nilai Aplikasi Tayangin",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                            "assets/icon_contact_me.svg"),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Kontak Bantuan",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                            "assets/icon_logout.svg"),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Keluar",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: generateDashedDivider(
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin),
                                  )
                                ],
                              ),
                            ),
                          )
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
