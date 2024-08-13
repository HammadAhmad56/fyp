import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showTabBar = false;
  String _tabBarType = '';

  void _showTabBarFor(String type) {
    setState(() {
      _showTabBar = true;
      _tabBarType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Plan of study'),
          bottom: _showTabBar
              ? TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  isScrollable: true, // Allow tabs to scroll horizontally
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Semester 1'),
                    Tab(text: 'Semester 2'),
                    Tab(text: 'Semester 3'),
                    Tab(text: 'Semester 4'),
                    Tab(text: 'Semester 5'),
                    Tab(text: 'Semester 6'),
                    Tab(text: 'Semester 7'),
                    Tab(text: 'Semester 8'),
                  ],
                  labelStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _showTabBarFor('BSIT'),
                  child: Text('BSIT'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _showTabBarFor('MIT'),
                  child: Text('MIT'),
                ),
              ],
            ),
            if (_showTabBar) Expanded(
              child: TabBarView(
                children: List.generate(9, (index) {
                  return Center(child: Text('Content for ${_tabBarType} - ${index + 1}'));
                }),
              ),
            ),
            if (!_showTabBar)
              Expanded(
                child: Center(
                  child: Text('Press a button to show the TabBar.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
