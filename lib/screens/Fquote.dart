import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteQuotes extends ChangeNotifier {
  final List<String> _favoriteQuotes = [];
  static const String _prefsKey =
      'favorite_quotes'; // Key for SharedPreferences

  FavoriteQuotes() {
    // Initialize quotes from SharedPreferences on creation
    _loadFromPrefs();
  }

  List<String> get quotes => _favoriteQuotes;

  void add(String quote) {
    if (!_favoriteQuotes.contains(quote)) {
      _favoriteQuotes.add(quote);
      _saveToPrefs(); // Save to SharedPreferences
      notifyListeners();
    }
  }

  void remove(int index) {
    _favoriteQuotes.removeAt(index);
    _saveToPrefs(); // Save updated list to SharedPreferences
    notifyListeners();
  }

  // Load quotes from SharedPreferences
  Future<void> _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? quotes = prefs.getStringList(_prefsKey);
    if (quotes != null) {
      _favoriteQuotes.addAll(quotes);
      notifyListeners();
    }
  }

  // Save quotes to SharedPreferences
  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _favoriteQuotes);
  }
}

Future<void> clearOldFavoriteQuotes() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('favoriteQuotes');
}
