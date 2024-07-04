import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/admin/Editprofile.dart';
import 'package:quoteza/admin/NotificationsSettings.dart';
import 'package:quoteza/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settingsscreen extends StatefulWidget {
  const Settingsscreen({Key? key}) : super(key: key);

  @override
  State<Settingsscreen> createState() => _SettingsscreenState();
}

class _SettingsscreenState extends State<Settingsscreen> {
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
      backgroundColor: Color(0xFFF7F2EF),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            buildListItem(
              context,
              Icons.account_circle,
              'Edit Profile',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Editprofile()),
                );
              },
            ),
            buildListItem(
              context,
              Icons.notifications,
              'Notification Settings',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsSettingsScreen()),
                );
              },
            ),
            buildListItem(
              context,
              Icons.security,
              'Security Settings',
              () {
                // Navigate to security settings screen
              },
            ),
            buildListItem(
              context,
              Icons.logout,
              'Logout',
              () {
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
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: Colors.grey,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
