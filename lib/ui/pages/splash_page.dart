part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    Future.delayed(Duration(seconds: 3), () {
      if (firebaseUser == null) {
        context.read<PageBloc>().add(GoToGetStartedPage());
      } else {
        // load user dan ticket
        context.read<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.read<TicketBloc>().add(GetTickets(firebaseUser.uid));

        context.read<PageBloc>().add(GoToMainPage());
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
              margin: EdgeInsets.only(top: 30),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Tayangin",
                    speed: Duration(milliseconds: 150),
                    textStyle: whiteTextFont.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
