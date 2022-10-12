// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_udemy/personalExpenses/pmain.dart';



void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pmain();
  }
}

