import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

//The Change
class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{};
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: "SecuriProperty",
        home: SplashScreen());
  }
}
