import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayangin_flutter/services/services.dart';

import 'ui/pages/pages.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.userStream,
        child: MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()));
  }
}
