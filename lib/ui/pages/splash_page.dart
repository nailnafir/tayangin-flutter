part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    Future.delayed(Duration(seconds: 3), () {
      if (firebaseUser == null) {
        // mencegah pindah ke page yang sama

        if (!(prevPageEvent is GoToGetStartedPage)) {
          prevPageEvent = GoToGetStartedPage();

          // belum pernah login
          context.read<PageBloc>().add(prevPageEvent);
        }
      } else {
        // mencegah pindah ke page yang sama
        if (!(prevPageEvent is GoToMainPage)) {
          // load user dan ticket
          context.read<UserBloc>().add(LoadUser(firebaseUser.uid));
          context.read<TicketBloc>().add(GetTickets(firebaseUser.uid));

          prevPageEvent = GoToMainPage();

          // sudah login
          context.read<PageBloc>().add(prevPageEvent);
        }
      }
    });

    return Scaffold(
      backgroundColor: mainColorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo_tayangin.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "Tayangin",
                style: whiteTextFont.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
