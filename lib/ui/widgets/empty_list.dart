part of 'widgets.dart';

class EmptyList extends StatelessWidget {
  final String title;
  final String assetPath;
  final double width;
  final double height;

  EmptyList(
      {@required this.title,
      @required this.assetPath,
      @required this.width,
      @required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Lottie.asset(assetPath),
          ),
          Text(
            title,
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
