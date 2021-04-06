part of 'pages.dart';

// wrapper akan mendapatkan firebaseUser dari status saat ini
// jika ada perubahan status, method build akan dipanggil kembali
class Wrapper extends StatefulWidget {
  final bool isSplashed;

  Wrapper({this.isSplashed});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isSplashed;

  @override
  void initState() {
    super.initState();

    isSplashed = false;
  }

  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    // mencegah pindah ke page yang sama untuk splash page
    if (!isSplashed) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.read<PageBloc>().add(prevPageEvent);
      }
    }

    // mencegah pindah ke page yang sama untuk get started page dan main page
    Future.delayed(Duration(seconds: !isSplashed ? 3 : 0), () {
      if (firebaseUser == null) {
        if (!(prevPageEvent is GoToGetStartedPage)) {
          prevPageEvent = GoToGetStartedPage();

          setState(() {
            isSplashed = true;
          });

          context.read<PageBloc>().add(prevPageEvent);
        }
      } else {
        if (!(prevPageEvent is GoToMainPage)) {
          prevPageEvent = GoToMainPage();

          setState(() {
            isSplashed = true;
          });

          context.read<UserBloc>().add(LoadUser(firebaseUser.uid));
          context.read<TicketBloc>().add(GetTickets(firebaseUser.uid));
          context.read<PageBloc>().add(prevPageEvent);
        }
      }
    });

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnGetStartedPage)
                ? GetStartedPage()
                : (pageState is OnLoginPage)
                    ? SignInPage()
                    : (pageState is OnRegistrationPage)
                        ? SignUpPage(pageState.registrationData)
                        : (pageState is OnPreferencePage)
                            ? PreferencePage(pageState.registrationData)
                            : (pageState is OnAccountConfirmationPage)
                                ? AccountConfirmationPage(
                                    pageState.registrationData)
                                : (pageState is OnForgotPasswordPage)
                                    ? ForgotPasswordPage()
                                    : (pageState is OnMovieDetailPage)
                                        ? MovieDetailPage(pageState.movie)
                                        : (pageState is OnSelectSchedulePage)
                                            ? SelectSchedulePage(
                                                pageState.movieDetail)
                                            : (pageState is OnSelectSeatPage)
                                                ? SelectSeatPage(
                                                    pageState.ticket)
                                                : (pageState is OnCheckoutPage)
                                                    ? CheckoutPage(
                                                        pageState.ticket)
                                                    : (pageState
                                                            is OnSuccessPage)
                                                        ? SuccessPage(
                                                            pageState.ticket,
                                                            pageState
                                                                .transaction)
                                                        : (pageState
                                                                is OnTicketDetailPage)
                                                            ? TicketDetailPage(
                                                                pageState
                                                                    .ticket)
                                                            : (pageState
                                                                    is OnProfilePage)
                                                                ? ProfilePage()
                                                                : (pageState
                                                                        is OnTopUpPage)
                                                                    ? TopUpPage(
                                                                        pageState
                                                                            .pageEvent)
                                                                    : (pageState
                                                                            is OnWalletPage)
                                                                        ? WalletPage(pageState
                                                                            .pageEvent)
                                                                        : (pageState
                                                                                is OnEditProfilePage)
                                                                            ? EditProfilePage(pageState.user)
                                                                            : (pageState is OnAboutAppsPage)
                                                                                ? AboutAppsPage()
                                                                                : (pageState is OnMainPage)
                                                                                    ? MainPage(
                                                                                        bottomNavBarIndex: pageState.bottomNavBarIndex,
                                                                                        isExpired: pageState.isExpired,
                                                                                      )
                                                                                    : Container());
  }
}
