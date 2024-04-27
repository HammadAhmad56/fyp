// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quoteza/Splashscreen.dart';
import 'Fquote.dart';

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
    return ChangeNotifierProvider(
      create: (context) => FavoriteQuotes(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF7F2EF)),
          primaryColor: Color(0xFFF7F2EF),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
