part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;
  final Function onTap;

  BrowseButton(this.genre, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: softColorSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SizedBox(
                height: 30,
                child: SvgPicture.asset(getImageFromGenre(genre)),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          genre,
          style:
              blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  String getImageFromGenre(String genre) {
    switch (genre) {
      case "Action":
        return "assets/icon_action.svg";
        break;
      case "Comedy":
        return "assets/icon_comedy.svg";
        break;
      case "Drama":
        return "assets/icon_drama.svg";
        break;
      case "Horror":
        return "assets/icon_horror.svg";
        break;
      case "Music":
        return "assets/icon_music.svg";
        break;
      case "War":
        return "assets/icon_war.svg";
        break;
      default:
        return "";
    }
  }
}
