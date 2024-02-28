// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:quoteza/Help.dart';
import 'package:quoteza/MainPage.dart';
import 'package:quoteza/Privacy-policy.dart';
import 'package:quoteza/Profile.dart';
import 'package:quoteza/Splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:quoteza/Terms.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF7F2EF),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF7F2EF)),
        primaryColor: Color(0xFFF7F2EF),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Profile(),
    );
  }
}
