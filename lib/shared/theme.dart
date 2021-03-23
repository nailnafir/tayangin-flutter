part of 'shared.dart';

const double defaultMargin = 24;

Color bgLight = Color(0xFFF3F3F3);
Color bgDark = Color(0xFF15153F);
Color mainColorPrimary = Color(0xFF15153F);
Color mainColorSecondary = Color(0xFFFE1D5F);
Color accentColorPrimary = Color(0xFF282A50);
Color accentColorSecondary = Color(0xFFFFE3EB);
Color accentColorDarkGray = Color(0xFFADADAD);
Color accentColorLightGray = Color(0xFFE3E3E3);
Color accentColorYellow = Color(0xFFECB53C);
Color accentColorGreen = Color(0xFF00AB1B);

TextStyle blackTextFont = GoogleFonts.poppins().copyWith(color: Colors.black);
TextStyle whiteTextFont = GoogleFonts.poppins().copyWith(color: Colors.white);
TextStyle grayTextFont =
    GoogleFonts.poppins().copyWith(color: accentColorDarkGray);

TextStyle blackNumberFont = GoogleFonts.lato().copyWith(color: Colors.black);
TextStyle whiteNumberFont = GoogleFonts.lato().copyWith(color: Colors.white);
TextStyle redNumberFont =
    GoogleFonts.lato().copyWith(color: mainColorSecondary);
TextStyle yellowNumberFont =
    GoogleFonts.lato().copyWith(color: accentColorYellow);
TextStyle greenNumberFont =
    GoogleFonts.lato().copyWith(color: accentColorGreen);
