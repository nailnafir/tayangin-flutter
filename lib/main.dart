import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tayangin_flutter/services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    SignInSignUpResult result = await AuthServices.signUp(
                        "jennie@blekping.com",
                        "654321",
                        "Jennie Jeje",
                        ["Action", "Horror", "Music", "Drama"],
                        "Korean");

                    if (result.user == null) {
                      print(result.message);
                    } else {
                      print(result.user.toString());
                    }
                  }),
              RaisedButton(
                  child: Text("Sign In"),
                  onPressed: () async {
                    SignInSignUpResult result = await AuthServices.signIn(
                        "jennie@blekping.com", "6543210");
                    if (result.user == null) {
                      print(result.message);
                    } else {
                      print(result.user.toString());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
