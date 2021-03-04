part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        body: Center(
          child: Text("Dompet Saya"),
        ),
      ),
    );
  }
}
