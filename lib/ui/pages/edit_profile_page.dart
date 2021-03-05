part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserApp user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData(primaryColor: mainColorYellow)));

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: <Widget>[
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
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Ubah Profil",
                              style: blackTextFont.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //NOTE: PHOTO
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 114,
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: (profileImageFile != null)
                                              ? FileImage(profileImageFile)
                                              : (profilePath != "")
                                                  ? NetworkImage(profilePath)
                                                  : AssetImage(
                                                      "assets/user_pic_default.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (profilePath == "") {
                                            profileImageFile = await getImage();

                                            if (profileImageFile != null) {
                                              profilePath = basename(
                                                  profileImageFile.path);
                                            }
                                          } else {
                                            profileImageFile = null;
                                            profilePath = "";
                                          }
                                        },
                                        child: Container(
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: provider.Svg((profilePath ==
                                                      "")
                                                  ? "assets/button_add_photo.svg"
                                                  : "assets/button_remove_photo.svg"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //NOTE: TEXTFIELD
                    AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(text: widget.user.id),
                        style:
                            blackTextFont.copyWith(color: accentColorDarkGray),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: "ID Pengguna",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    AbsorbPointer(
                      child: TextField(
                        controller:
                            TextEditingController(text: widget.user.email),
                        style:
                            blackTextFont.copyWith(color: accentColorDarkGray),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: "Email",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: nameController,
                      onChanged: (text) {
                        setState(() {
                          isDataEdited = (text.trim() != widget.user.name ||
                                  profilePath != widget.user.profilePicture)
                              ? true
                              : false;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Nama Lengkap",
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 250,
                      height: 50,
                      child: RaisedButton(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              MdiIcons.alertCircle,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Ubah Password",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: (isUpdating)
                                    ? accentColorDarkGray
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              MdiIcons.alertCircle,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                        disabledColor: accentColorLightGray,
                        color: Colors.red,
                        onPressed: (isUpdating)
                            ? null
                            : () async {
                                await AuthServices.resetPassword(
                                    widget.user.email);

                                Flushbar(
                                  duration: Duration(milliseconds: 3000),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: accentColorRed,
                                  message:
                                      "Kami sudah kirimkan link reset password ke email kamu",
                                ).show(context);
                              },
                      ),
                    ),
                    SizedBox(height: 20),
                    (isUpdating)
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitFadingCircle(color: accentColorGreen),
                          )
                        : Container(
                            width: 250,
                            height: 50,
                            child: RaisedButton(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Ubah Profil Saya",
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (isDataEdited)
                                      ? Colors.white
                                      : accentColorDarkGray,
                                ),
                              ),
                              disabledColor: accentColorLightGray,
                              color: accentColorGreen,
                              onPressed: (isDataEdited)
                                  ? () async {
                                      // ubah status update jadi true
                                      setState(() {
                                        isUpdating = true;
                                      });

                                      // validasi untuk upload image
                                      if (profileImageFile != null) {
                                        profilePath =
                                            await uploadImage(profileImageFile);
                                      }

                                      // update data user dengan bloc
                                      context.bloc<UserBloc>().add(UpdateData(
                                            name: nameController.text,
                                            profileImage: profilePath,
                                          ));
                                    }
                                  : null,
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
