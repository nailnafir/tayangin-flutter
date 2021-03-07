part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final bool isExpired;

  MainPage({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onBackPressed() {
      return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Konfirmasi",
                  style: blackTextFont.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                content: Text(
                  "Yakin mau keluar aplikasi?",
                  style: blackTextFont.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      "Tidak",
                      style: whiteTextFont.copyWith(
                        color: accentColorGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false); // tidak keluar
                    },
                  ),
                  TextButton(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: accentColorRed,
                      ),
                      child: Text(
                        "Keluar",
                        style: whiteTextFont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true); // keluar
                    },
                  ),
                ],
              );
            },
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(color: mainColorBlue),
            SafeArea(child: Container(color: Colors.white)),
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                });
              },
              children: <Widget>[
                MoviePage(),
                TicketPage(isExpiredTicket: widget.isExpired),
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
                    context.bloc<PageBloc>().add(GoToTopUpPage(GoToMainPage()));
                  },
                ),
              ),
            ),
          ],
        ),
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
              unselectedItemColor: accentColorDarkGray,
              currentIndex: bottomNavBarIndex,
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;
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
                    child: SvgPicture.asset((bottomNavBarIndex == 0)
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
                    child: SvgPicture.asset((bottomNavBarIndex == 1)
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
