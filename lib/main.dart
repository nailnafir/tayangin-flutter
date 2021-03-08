import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tayangin_flutter/bloc/blocs.dart';
import 'package:tayangin_flutter/bloc/page_bloc.dart';
import 'package:tayangin_flutter/bloc/theme_bloc.dart';
import 'package:tayangin_flutter/services/services.dart';

import 'ui/pages/pages.dart';

Future<void> main() async {
  // firebase versi baru harus inisialisasi dulu untuk dipanggil
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.userStream,
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => PageBloc()),
              BlocProvider(create: (_) => UserBloc()),
              BlocProvider(create: (_) => ThemeBloc()),
              BlocProvider(create: (_) => MovieBloc()..add(FetchMovies())),
              BlocProvider(create: (_) => TicketBloc())
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, themeState) => MaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: Wrapper()),
            )));
  }
}
