part of 'widgets.dart';

class CreditCard extends StatelessWidget {
  final Credit credit;
  CreditCard(this.credit);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            Shimmer.fromColors(
              period: Duration(seconds: 1),
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                height: 80,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            credit.profilePath == null
                ? Container(
                    height: 80,
                    width: 70,
                    padding: EdgeInsets.all(defaultMargin / 2),
                    decoration: BoxDecoration(
                      color: mainColorPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/user_pic_default.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  )
                : Container(
                    height: 80,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(
                              imageBaseURL + "w185" + credit.profilePath),
                          fit: BoxFit.cover),
                    ),
                  ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          width: 70,
          child: Text(
            credit.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: blackTextFont.copyWith(
                fontSize: 12, fontWeight: FontWeight.w400, height: 1.2),
          ),
        )
      ],
    );
  }
}
