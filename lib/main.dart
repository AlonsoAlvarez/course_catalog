import 'package:children_now/providers/app_state.dart';
import 'package:children_now/services/wrapped.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppState())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Niños ahora',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xff000000, {
          50: Color.fromRGBO(0, 0, 0, .1),
          100: Color.fromRGBO(0, 0, 0, .2),
          200: Color.fromRGBO(0, 0, 0, .3),
          300: Color.fromRGBO(0, 0, 0, .4),
          400: Color.fromRGBO(0, 0, 0, .5),
          500: Color.fromRGBO(0, 0, 0, .6),
          600: Color.fromRGBO(0, 0, 0, .7),
          700: Color.fromRGBO(0, 0, 0, .8),
          800: Color.fromRGBO(0, 0, 0, .9),
          900: Color.fromRGBO(0, 0, 0, 1)
        }),
      ),
      home: const Wrapped()
    );
  }
}
