part of 'pages.dart';

// wrapper akan mendapatkan firebaseUser dari status saat ini
//jika ada perubahan status, method build akan dipanggil kembali
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      // mencegah pindah ke page yang sama

      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();

        // belum pernah login
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      // mencegah pindah ke page yang sama
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        prevPageEvent = GoToMainPage();

        // sudah login
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : MainPage);
  }
}
