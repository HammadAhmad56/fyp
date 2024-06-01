// ignore_for_file: prefer_const_constructors, prefer_const_declarations
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/Fquote.dart';
import 'package:quoteza/Profile.dart';
import 'package:quoteza/Subscription.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

String fq = "";

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String quote = '';
  bool isLoading = true;
  late Timer _timer;
  List<String> favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _fetchAndSetQuote();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      _fetchAndSetQuote();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchAndSetQuote() async {
    setState(() {
      isLoading = true;
    });

    final String category = 'inspirational';
    final String apiKey = 'k5YwnsfH2bYVbHaB3fEDsg==KLeGv9AxjJNj4Jam';

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          isLoading = false;
          quote = 'No internet connection';
        });
        return;
      }

      final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/quotes?category=$category'),
        headers: {'X-Api-Key': apiKey},
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List && responseData.isNotEmpty) {
          setState(() {
            isLoading = false;
            quote = responseData[0]['quote'];
          });
        } else {
          setState(() {
            isLoading = false;
            quote = 'Quote not found in response';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          quote = 'Failed to load quotes';
        });
      }
    } on TimeoutException {
      setState(() {
        isLoading = false;
        quote = 'Failed to load quotes (timeout)';
      });
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
        quote = 'Error: $e';
      });
    }
  }

  void _addToFavorites() async {
    if (quote.isNotEmpty && !favoriteQuotes.contains(quote)) {
      if (!quote.contains('Failed to load quotes') &&
          !quote.contains('Failed to load quotes (timeout)') &&
          !quote.contains('No internet connection') &&
          !quote.contains('Error')) {
        setState(() {
          !favoriteQuotes.contains(quote);
          favoriteQuotes.add(quote);
          favoriteQuotes = [...favoriteQuotes, quote];
          Provider.of<FavoriteQuotes>(context, listen: false).add(quote);
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('favoriteQuotes', favoriteQuotes);
        // snack bar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Quote added to favorites!'),
            duration: Duration(seconds: 1),
          ),
        );
      } else if (favoriteQuotes.contains(quote)) {
        // If the quote is already in favorites, show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Quote already in favorites!'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error: Cannot add this quote to favorites!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Quote is invalid or already in favorites!'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteQuotes = prefs.getStringList('favoriteQuotes') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    String sharing =
        "Hi this is my app check that's awesome quote \n\n*$quote*\nThis is my application check out ";
    return PopScope(
      canPop: false,
      child: Scrollbar(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: const [
              Color(0xFFF7F2EF),
              Colors.white,
              Color(0xFFF7F2EF)
            ], begin: Alignment.bottomLeft)),
            child: Stack(
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
                          _addToFavorites();
                        },
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          // Handle load button press
                          Share.share(
                            sharing,
                            subject: "Motivational quote app",
                          );
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
                  child: Container(
                    width: 50, // Adjust the width and height to make it square
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(
                          8), // Adjust the radius for rounded corners if needed
                    ),
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {
                        // Handle profile button press
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black, // Adjust icon color if needed
                        size: 30,
                      ),
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
                      backgroundColor: Color(0xFFF7F2EF),
                      elevation: 0,
                      textStyle: TextStyle(fontSize: 16, color: Colors.black),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(0xFFF7F2EF),
                      ))
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            quote,
                            style: GoogleFonts.nunito(
                              fontSize: 24,
                              color: Color(0xFFF7F2EF),
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 5,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
