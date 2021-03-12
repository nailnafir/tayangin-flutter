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
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 3.0))
            ],
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
              Shimmer.fromColors(
                baseColor: mainColorYellow,
                highlightColor: Colors.white,
                child: Text(
                  "DISC ${promo.discount}%",
                  style: yellowNumberFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        ShaderMask(
          shaderCallback: (rectangle) {
            return LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ]).createShader(Rect.fromLTRB(0, 0, 105, 80));
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            height: 80,
            width: 105,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: SvgPicture.asset("assets/reflection1.svg")),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ]).createShader(Rect.fromLTRB(0, 0, 155, 45));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 45,
              width: 155,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                  ),
                  child: SvgPicture.asset("assets/reflection2.svg")),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.transparent,
                  ]).createShader(Rect.fromLTRB(0, 0, 135, 25));
            },
            blendMode: BlendMode.dstIn,
            child: SizedBox(
              height: 25,
              width: 135,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                  ),
                  child: SvgPicture.asset("assets/reflection3.svg")),
            ),
          ),
        )
      ],
    );
  }
}
