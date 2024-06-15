// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FavoriteQuotes extends ChangeNotifier {
  final List<String> _favoriteQuotes = [];

  List<String> get quotes => _favoriteQuotes;

  void add(String quote) {
    _favoriteQuotes.add(quote);
    notifyListeners();
  }

  void remove(int index) {
    _favoriteQuotes.removeAt(index);
    notifyListeners();
  }
}
