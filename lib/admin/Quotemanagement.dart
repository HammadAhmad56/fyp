// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/admin/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Quotemanagement extends StatefulWidget {
  const Quotemanagement({super.key});

  @override
  State<Quotemanagement> createState() => _QuotemanagementState();
}

class _QuotemanagementState extends State<Quotemanagement> {
  final List<String> allquotes = [
    'Age',
    'Alone',
    'Amazing',
    'Anger',
    'Architecture',
    'Art',
    'Attitude',
    'Beauty',
    'Best',
    'Birthday',
    'Business',
    'Car',
    'Change',
    'Communication',
    'Computers',
    'Cool',
    'Courage',
    'Dad',
    'Dating',
    'Death',
    'Design',
    'Dreams',
    'Education',
    'Environmental',
    'Equality',
    'Experience',
    'Failure',
    'Faith',
    'Family',
    'Famous',
    'Fear',
    'Fitness',
    'Food',
    'Forgiveness',
    'Freedom',
    'Friendship',
    'Funny',
    'Future',
    'God',
    'Good',
    'Government',
    'Graduation',
    'Great',
    'Happiness',
    'Health',
    'History',
    'Home',
    'Hope',
    'Humor',
    'Imagination',
    'Inspirational',
    'Intelligence',
    'Jealousy',
    'Knowledge',
    'Leadership',
    'Learning',
    'Legal',
    'Life',
    'Love',
    'Marriage',
    'Medical',
    'Men',
    'Mom',
    'Money',
    'Morning',
    'Movies',
    'Success',
  ];

  String category = 'Inspirational'; // Initial value set to 'Age'
  final TextEditingController _controller =
      TextEditingController(text: 'Inspirational');

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  void _loadCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedCategory = prefs.getString('selectedCategory');
    if (savedCategory != null && allquotes.contains(savedCategory)) {
      setState(() {
        category = savedCategory;
        _controller.text = savedCategory;
      });
    }
  }

  void _saveCategory(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedCategory', value);
  }

  void _validateCategory(String value) {
    if (!allquotes.contains(value)) {
      final random = Random();
      final randomCategory = allquotes[random.nextInt(allquotes.length)];
      setState(() {
        category = randomCategory;
        _controller.text = randomCategory;
      });
    } else {
      setState(() {
        category = value;
      });
    }
    _saveCategory(category); // Save the valid category
  }

  void _clearCategory() {
    _controller.clear();
    setState(() {
      category = 'Inspirational'; // Reset to the initial value
    });
    _saveCategory('Inspirational'); // Save the initial value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Color.fromARGB(255, 247, 220, 211),
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true,
        leadingWidth: 30,
        title: Text(
          "Quote Management",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF7F2EF),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: EasyAutocomplete(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search or Select a Category',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearCategory,
                ),
              ),
              suggestions: allquotes,
              onChanged: (value) {
                if (allquotes.contains(value)) {
                  _validateCategory(value);
                }
              },
              onSubmitted: (value) {
                _validateCategory(value);
              },
            ),
          ),
          if (category.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Current Category: $category",
                style: GoogleFonts.nunito(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the drawer first
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
