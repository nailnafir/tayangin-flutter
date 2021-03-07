part of 'shared.dart';

const double defaultMargin = 24;

Color mainColorBlue = Color(0xFF020080);
Color mainColorYellow = Color(0xFFFFC956);
Color accentColorBlue1 = Color(0xFF3A3988);
Color accentColorBlue2 = Color(0xFF7070B0);
Color accentColorDarkGray = Color(0xFFADADAD);
Color accentColorLightGray = Color(0xFFE3E3E3);
Color accentColorRed = Color(0xFFF12153);
Color accentColorYellow = Color(0xFFFFF3DE);
Color accentColorGreen = Color(0xFF00AB1B);

TextStyle blackTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle grayTextFont = GoogleFonts.poppins()
    .copyWith(color: accentColorDarkGray, fontWeight: FontWeight.w500);
TextStyle yellowTextFont = GoogleFonts.poppins()
    .copyWith(color: mainColorYellow, fontWeight: FontWeight.w500);

TextStyle blackNumberFont = GoogleFonts.lato().copyWith(color: Colors.black);
TextStyle whiteNumberFont = GoogleFonts.lato().copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    GoogleFonts.lato().copyWith(color: mainColorYellow);
TextStyle redNumberFont = GoogleFonts.lato().copyWith(color: accentColorRed);
TextStyle greenNumberFont =
    GoogleFonts.lato().copyWith(color: accentColorGreen);
