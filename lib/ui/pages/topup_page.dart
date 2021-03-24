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
          primaryColor: mainColorPrimary,
        )));

    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 18 - 18) / 3;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: bgLight,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Container(color: bgLight),
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
                        onChanged: (text) {
                          // kalau dia angka, tambahkan ke temp (concat). kalo tidak, concat dengan string kosong

                          String temp = '';
                          for (int i = 0; i < text.length; i++) {
                            temp += text.isDigit(i) ? text[i] : '';
                          }

                          // ubah temp ke bentuk integer
                          setState(() {
                            selectedAmount = int.tryParse(temp) ?? 0;
                          });

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
                        controller: amountController,
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
                          makeMoneyCard(
                            amount: 50000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 100000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 150000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 200000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 250000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 500000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 1000000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 2500000,
                            width: cardWidth,
                          ),
                          makeMoneyCard(
                            amount: 5000000,
                            width: cardWidth,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        width: 250,
                        height: 50,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) {
                            return FloatingActionButton(
                              elevation: 2,
                              backgroundColor: selectedAmount > 0
                                  ? accentColorGreen
                                  : accentColorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                'Isi Saldo Sekarang',
                                style: selectedAmount > 0
                                    ? whiteTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0,
                                      )
                                    : grayTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0,
                                      ),
                              ),
                              onPressed: selectedAmount > 0
                                  ? () {
                                      context.bloc<PageBloc>().add(
                                            GoToSuccessPage(
                                              null,
                                              TayanginTransaction(
                                                userID:
                                                    (userState as UserLoaded)
                                                        .user
                                                        .id,
                                                title: "Isi Saldo",
                                                subtitle:
                                                    "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}",
                                                amount: selectedAmount,
                                                time: DateTime.now(),
                                              ),
                                            ),
                                          );
                                    }
                                  : null,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  MoneyCard makeMoneyCard({int amount, double width}) {
    return MoneyCard(
      amount: amount,
      width: width,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(() {
          // select amount dan deselect
          if (selectedAmount != amount) {
            selectedAmount = amount;
          } else {
            selectedAmount = 0;
          }

          // buat input text nya bernilai sama dengan yang diselect amount
          amountController.text = NumberFormat.currency(
            locale: 'id_ID',
            decimalDigits: 0,
            symbol: 'IDR ',
          ).format(selectedAmount);

          // pindahkan kursor ke belakang
          amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: amountController.text.length));
        });
      },
    );
  }
}
