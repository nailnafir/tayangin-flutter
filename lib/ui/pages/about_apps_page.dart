part of 'pages.dart';

class AboutAppsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  //NOTE: HEADER
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(1),
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToProfilePage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Text(
                          "Tentang Aplikasi",
                          style: blackTextFont.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
