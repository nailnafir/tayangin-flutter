part of 'extensions.dart';

extension FirebaseUserExtension on auth.User {
  UserApp convertToUser(
          {String name = "No Name",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 50000}) =>
      UserApp(this.uid, this.email,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  Future<UserApp> fromFireStore() async => await UserServices.getUser(this.uid);
}
