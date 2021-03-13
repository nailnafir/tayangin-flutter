part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final TayanginTransaction transaction;
  final double width;

  TransactionCard(this.transaction, this.width);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: [
            Shimmer.fromColors(
              period: Duration(seconds: 1),
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Container(
              height: 100,
              width: 80,
              margin: EdgeInsets.only(right: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: (transaction.picture != null)
                      ? NetworkImage(
                          imageBaseURL + "w500" + transaction.picture)
                      : AssetImage("assets/icon_bg_default_top_up.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              width: width - 80 - 18,
              child: Text(
                transaction.title,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: blackTextFont.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: width - 80 - 18,
              child: Text(
                NumberFormat.currency(
                        locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
                    .format(transaction.amount < 0
                        ? -transaction.amount
                        : transaction.amount),
                style: transaction.amount < 0
                    ? redNumberFont.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400)
                    : greenNumberFont.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: width - 80 - 18,
              child: Text(
                transaction.subtitle,
                style: grayTextFont.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
