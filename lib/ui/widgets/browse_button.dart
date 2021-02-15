part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;
  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    return Text(genre);
  }
}
