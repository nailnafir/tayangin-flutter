part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(
          primaryColor: mainColorYellow,
        )));

    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 18 - 18) / 3;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: <Widget>[
                      //NOTE: ICON BACK
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(1),
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(widget.pageEvent);
                                },
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Isi Saldo",
                                style: blackTextFont.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //NOTE: TEXTFIELD
                      SizedBox(height: 30),
                      TextField(
                        controller: amountController,
                        onChanged: (text) {
                          // kalau dia angka, tambahkan ke temp (concat)
                          // kalo tidak, concat dengan string kosong
                          String temp = '';
                          for (int i = 0; i < text.length; i++) {
                            temp += text.isDigit(i) ? text[i] : '';
                          }

                          // ubah temp ke bentuk integer
                          selectedAmount = int.tryParse(temp) ?? 0;

                          // buat format currency ke IDR
                          amountController.text = NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'IDR ',
                            decimalDigits: 0,
                          ).format(selectedAmount);

                          // pindahkan kursor textfield ke paling belakang
                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: amountController.text.length));
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: "Jumlah",
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 30, bottom: 12),
                          child: Text(
                            "Pilih Sesukamu",
                            style: blackTextFont.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 18, // jarak horizontal
                        runSpacing: 18, // jarak vertikal
                        children: <Widget>[
                          MoneyCard(
                            amount: 50000,
                            width: cardWidth,
                          ),
                          MoneyCard(
                            amount: 50000,
                            width: cardWidth,
                          ),
                          MoneyCard(
                            amount: 50000,
                            width: cardWidth,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
