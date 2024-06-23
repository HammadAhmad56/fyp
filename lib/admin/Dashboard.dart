// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Add_Removeuser.dart';
import 'Userdetails.dart';
import 'Settings.dart';
import 'Usermanagement.dart';
import '../admin/Quotemanagement.dart';
import 'package:quoteza/admin/Quotemanagement.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() async {
    await _auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove("key"); //ya key email ki ha
    await prefs.remove("key2"); //ya key password ki ha
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        surfaceTintColor: Color.fromARGB(255, 247, 220, 211),
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
        automaticallyImplyLeading: true,
        leadingWidth: 30,
        title: Text(
          "Dashboard",
          style: GoogleFonts.nunito(),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // zoomDrawerController.toggle!();
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        width: 250,
        surfaceTintColor: Color.fromARGB(255, 247, 220, 211),
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 220, 211),
              ),
              child: Text('Quoteza',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  )),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.format_quote),
              title: Text('Quote Management'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Quotemanagement()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add_alt_1),
              title: Text('Add OR Remove User'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRemoveuser()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('User Details'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDetails()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.supervisor_account),
              title: Text('User Management'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Usermanagement()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
                // Add navigation logic here if needed
              },
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Do you want to Logout??"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  signOut();
                                },
                                child: Text(
                                  "Yes",
                                  style: GoogleFonts.nunito(color: Colors.red),
                                ),
                              ),
                            ],
                          ));
                },
                child: Text('Logout'))
          ],
        ),
      ),
      body: Center(
        child: Text('Main Content Area'),
      ),
    );
  }
}
