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
                        ],
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
