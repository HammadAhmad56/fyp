// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Fquote.dart'; // Import the FavoriteQuotes class

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the FavoriteQuotes provider
    final favoriteQuotesProvider = Provider.of<FavoriteQuotes>(context);

    // Get the list of favorite quotes
    final List<String> favoriteQuotes = favoriteQuotesProvider.quotes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F2EF),
        surfaceTintColor: Color(0xFFF7F2EF),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        automaticallyImplyLeading: true,
        leadingWidth: 30,
        title: Text(
          "Favorite",
          style: GoogleFonts.nunito(),
        ),
      ),
      backgroundColor: Color(0xFFF7F2EF),
      body: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          final quote = favoriteQuotes[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.green,
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                quote,
                style: GoogleFonts.nunito(),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.pink.shade300,
                ),
                onPressed: () {
                  // Remove the quote from favorites when the heart button is pressed
                  favoriteQuotesProvider.remove(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
