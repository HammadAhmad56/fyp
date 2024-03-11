// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/Profile.dart';
import 'package:quoteza/Subscription.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String quote = '';

  Future<void> fetchQuote() async {
    final String category = 'inspirational';
    final String apiKey = 'k5YwnsfH2bYVbHaB3fEDsg==KLeGv9AxjJNj4Jam';

    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/quotes?category=$category'),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        quote = responseData[0]
            ['quote']; // Assuming 'quote' is a property of the quote object
      });
    } else {
      throw Exception('Failed to load quote');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scrollbar(
      child: Scaffold(
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Subscription()),
                  );
                },
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
              child: quote.isEmpty
                  ? CircularProgressIndicator()
                  : Text(
                      quote,
                      style: GoogleFonts.nunito(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
