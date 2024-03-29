part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final bool isSelected;
  final double width;
  final double height;
  final DateTime date;
  final Function onTap;

  DateCard(this.date,
      {this.isSelected = false,
      this.width = 70,
      this.height = 100,
      this.onTap});

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
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? mainColorSecondary : Colors.transparent,
          border: Border.all(
              color: isSelected ? Colors.transparent : accentColorLightGray),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              date.dayName.toUpperCase(),
              style: isSelected ? whiteTextFont : blackTextFont,
            ),
            SizedBox(height: 6),
            Text(
              (date.day.toString() + " " + date.shortMonthName.toString())
                  .toUpperCase(),
              style: isSelected ? whiteTextFont : blackTextFont,
            ),
          ],
        ),
      ),
    );
  }
}
