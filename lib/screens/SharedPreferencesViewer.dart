import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesViewer extends StatefulWidget {
  @override
  _SharedPreferencesViewerState createState() =>
      _SharedPreferencesViewerState();
}

class _SharedPreferencesViewerState extends State<SharedPreferencesViewer> {
  Map<String, dynamic> _allPreferences = {};

  @override
  void initState() {
    super.initState();
    _fetchAllPreferences();
  }

  Future<void> _fetchAllPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _allPreferences = prefs.getKeys().fold({}, (prev, key) {
        prev[key] = prefs.get(key);
        return prev;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Viewer'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: _allPreferences.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            subtitle: Text(entry.value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
