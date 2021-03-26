part of 'models.dart';

class TutorialResetPassword extends Equatable {
  final String tutorial;

  TutorialResetPassword(this.tutorial);

  @override
  List<Object> get props => [tutorial];
}

List<TutorialResetPassword> dummyTutorial = [
  TutorialResetPassword(
      "Pastikan kamu sudah, harus, kudu, dan wajib terdaftar di Aplikasi Tayangin."),
  TutorialResetPassword("Masukkan email kamu dibawah."),
  TutorialResetPassword("Tekan tombol reset password."),
  TutorialResetPassword(
      "Periksa email kamu, karena link untuk reset passwordnya dikirim ke email kamu."),
  TutorialResetPassword("Kunjungi link yang sudah dikirim tadi."),
  TutorialResetPassword("Buat password baru di sana."),
  TutorialResetPassword("Selesai deh, password berhasil diganti."),
];
