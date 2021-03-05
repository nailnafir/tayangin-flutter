part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserApp user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
        body: Center(
          child: Text(widget.user.name),
        ),
      ),
    );
  }
}
