part of 'pages.dart';

// wrapper akan mendapatkan firebaseUser dari status saat ini
// jika ada perubahan status, method build akan dipanggil kembali
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PageBloc>().add(GoToSplashPage());

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
