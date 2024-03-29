part of 'services.dart';

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      // daftarkan email dan password ke firebase auth
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // membuat data user di firestore convert dari firebaseUser ke User
      UserApp user = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      // setelah menjadi user, kirim ke firestore
      await UserServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      // return SignInSignUpResult(message: e.toString().split(']')[1].trim());
      return SignInSignUpResult(message: (e as FirebaseException).message);
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      // jika signIn berhasil, maka akan ambil data user dari firestore
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserApp user = await result.user.fromFireStore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      // return SignInSignUpResult(message: e.toString().split(']')[1].trim());
      return SignInSignUpResult(message: (e as FirebaseException).message);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // menghubungkan aplikasi dengan authentication firebase
  static Stream<auth.User> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  final UserApp user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
