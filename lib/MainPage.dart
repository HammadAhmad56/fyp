// ignore_for_file: prefer_const_constructors,

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/Profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/home.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 200,
            left: 128,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Handle heart button press
                  },
                  icon: Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    // Handle favorite button press
                  },
                  icon: Icon(
                    Icons.file_download_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              onPressed: () {
                // Handle profile button press
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                textStyle: TextStyle(fontSize: 16, color: Colors.black),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.white),
                ),
              ),
              icon: Icon(
                FontAwesomeIcons.crown,
                size: 16,
                color: Colors.black,
              ),
              label: Text(
                "Premium",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          Center(
            child: Text(
              "Motivation",
              style: GoogleFonts.nunito(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
