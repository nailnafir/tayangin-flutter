part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function onTap;

  MoneyCard(
      {this.width = 90, this.isSelected = false, this.amount = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected ? Colors.transparent : accentColorLightGray),
          color: isSelected ? mainColorSecondary : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('IDR',
                style: grayTextFont.copyWith(
                  color: isSelected ? hardColorSecondary : accentColorDarkGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(height: 4),
            Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  decimalDigits: 0,
                  symbol: '',
                ).format(amount),
                style: isSelected ? whiteTextFont : blackTextFont),
          ],
        ),
      ),
    );
  }
}
