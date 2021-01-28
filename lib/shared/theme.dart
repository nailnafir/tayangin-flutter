part of 'shared.dart';

const double defaultMargin = 24;

Color mainColorBlue = Color(0xFF020080);
Color mainColorYellow = Color(0xFFFFC956);
Color accentColorBlue1 = Color(0xFF3A3988);
Color accentColorBlue2 = Color(0xFF52519D);
Color accentColorDarkGray = Color(0xFFADADAD);
Color accentColorLightGray = Color(0xFFE3E3E3);
Color accentColorRed = Color(0xFFF12153);
Color accentColorGreen = Color(0xFF00AB1B);

TextStyle blackTextFont = GoogleFonts.montserrat()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.montserrat()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle yellowNumberFont =
    GoogleFonts.montserrat().copyWith(color: mainColorYellow);
TextStyle redNumberFont =
    GoogleFonts.montserrat().copyWith(color: accentColorRed);
TextStyle greenNumberFont =
    GoogleFonts.montserrat().copyWith(color: accentColorGreen);