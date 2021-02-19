part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavbarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavbarIndex = 0;
    pageController = PageController(initialPage: bottomNavbarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(color: mainColorBlue),
          SafeArea(child: Container(color: Colors.white)),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavbarIndex = index;
              });
            },
            children: <Widget>[
              MoviePage(),
              Center(
                child: Text("Tiket Saya"),
              )
            ],
          ),
          createCustomBottomNavbar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: mainColorYellow,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    MdiIcons.walletPlus,
                    color: Colors.black.withOpacity(0.55),
                    size: 24,
                  ),
                ),
                onPressed: () {
                  context.bloc<UserBloc>().add(SignOut());
                  AuthServices.signOut();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createCustomBottomNavbar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavbarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: accentColorYellow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: mainColorBlue,
              unselectedItemColor: accentColorLightGray,
              currentIndex: bottomNavbarIndex,
              onTap: (index) {
                setState(() {
                  bottomNavbarIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text(
                    "Koleksi Film",
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset((bottomNavbarIndex == 0)
                        ? "assets/icon_movies_colored.svg"
                        : "assets/icon_movies_gray.svg"),
                  ),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    "Tiket Saya",
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 4),
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset((bottomNavbarIndex == 1)
                        ? "assets/icon_my_ticket_colored.svg"
                        : "assets/icon_my_ticket_gray.svg"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class BottomNavbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 36, 0);
    path.quadraticBezierTo(size.width / 2 - 36, 38, size.width / 2, 38);
    path.quadraticBezierTo(size.width / 2 + 36, 38, size.width / 2 + 36, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
