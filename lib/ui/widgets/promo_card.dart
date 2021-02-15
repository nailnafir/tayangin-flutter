part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;
  PromoCard(this.promo);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: mainColorBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    promo.title,
                    style: whiteTextFont.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    promo.subtitle,
                    style: whiteTextFont.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              Text(
                "DISC ${promo.discount}%",
                style: yellowNumberFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ],
    );
  }
}
