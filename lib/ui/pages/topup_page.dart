part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');

  @override
  Widget build(BuildContext context) {
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
                        onChanged: (text) {},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: "Jumlah",
                        ),
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
