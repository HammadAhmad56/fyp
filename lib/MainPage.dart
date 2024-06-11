// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
String quote = '';
String author = '';
List<String> favoriteQuotes = [];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = true;
  late Timer _timer;

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
          author = "No internet connection";
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
            author = responseData[0]['author'];
          });
        } else {
          setState(() {
            isLoading = false;
            quote = 'Quote not found in response';
            author = 'Author not found in response';
          });
        }
      } else {
        setState(() {
          isLoading = false;
          quote = 'Failed to load quotes';
          author = 'Failed to load author';
        });
      }
    } on TimeoutException {
      setState(() {
        isLoading = false;
        quote = 'Failed to load quotes (timeout)';
        author = 'Failed to load author (timeout)';
      });
    } on Exception catch (e, a) {
      setState(() {
        isLoading = false;
        quote = 'Error: $e';
        author = 'Error:$a';
      });
    }
  }

  void _addToFavorites() async {
    if (quote.isNotEmpty && !favoriteQuotes.contains(quote)) {
      if (!quote.contains('Failed to load quotes') &&
          !quote.contains('Failed to load quotes (timeout)') &&
          !quote.contains('No internet connection') &&
          !quote.contains('Error') &&
          !author.contains('Failed to load author') &&
          !author.contains('Failed to load author (timeout)') &&
          !author.contains('No internet connection') &&
          !author.contains('Error')) {
        setState(() {
          !favoriteQuotes.contains(quote + author);
          favoriteQuotes.add(quote + author);
          favoriteQuotes = [...favoriteQuotes, quote, author];
          Provider.of<FavoriteQuotes>(context, listen: false)
              .add(quote + author);
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
                Column(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 40, end: 20),
                      alignment: Alignment.topRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Subscription()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF7F2EF),
                          elevation: 0,
                          textStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
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
                    SizedBox(
                      height: 100,
                    ),
                    isLoading
                        ? Container(
                            height: 250.0, // Set a fixed height
                            width: double.infinity, // Set a fixed width
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFF7F2EF),
                              ),
                            ),
                          )
                        : Container(
                            height: 250.0, // Set the same fixed height
                            width: double.infinity, // Set the same fixed width
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "$quote\n$author",
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
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 60),
                    Padding(padding: EdgeInsets.all(0)),
                    ElevatedButton(
                      onPressed: () {
                        _fetchAndSetQuote();
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Text("Press me", style: GoogleFonts.nunito()),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        width:
                            50, // Adjust the width and height to make it square
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(
                              8), // Adjust the radius for rounded corners if needed
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Handle profile button press
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()));
                          },
                          icon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black, // Adjust icon color if needed
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // child: RichText(
                //   text: TextSpan(spellOut: true,
                //     text: '$quote ', // First part of the text
                //     style: GoogleFonts.nunito(
                //       fontSize: 24,
                //       color: Color(0xFFF7F2EF),
                //       fontWeight: FontWeight.bold,
                //     ),
                //   //    overflow: TextOverflow.ellipsis,
                //   // textAlign: TextAlign.center,
                //   // maxLines: 5,
                //     children: <TextSpan>[
                //       TextSpan(
                //         text:
                //             '$author', // Second part of the text with a different color
                //          style: GoogleFonts.nunito(
                //       fontSize: 24,
                //       color: Color.fromARGB(255, 230, 9, 24),
                //       fontWeight: FontWeight.bold,
                //     ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
