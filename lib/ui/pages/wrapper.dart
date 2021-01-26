part of 'pages.dart';

// wrapper akan mendapatkan firebaseUser dari status saat ini
//jika ada perubahan status, method build akan dipanggil kembali
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      // belum pernah login
      return SignInPage();
    } else {
      // sudah login
      return MainPage();
    }
  }
}
