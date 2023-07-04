// ignore_for_file: prefer_const_constructors

import 'package:assignment5/screens/addUser.dart';
import 'package:assignment5/screens/all_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue,
          textTheme: GoogleFonts.exo2TextTheme(
          Theme.of(context).textTheme
      )),
      home: AllData(),
    );
  }
}
