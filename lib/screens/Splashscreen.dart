// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quoteza/admin/Dashboard.dart';
import 'MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quoteza/auth/login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void signInWithEmailAndPassword() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: prefs.getString("email") ?? "null",
        password: prefs.getString("password") ?? "null",
      );

      final User? user = userCredential.user;

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        // Navigate to another screen after successful login
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AnotherScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Enter the correct Email or Password!'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Error signing in: $e');
      // Handle sign-in errors here
    }
  }

 void autologin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String role = prefs.getString('role') ?? 'user'; // Default to 'user' if no role is found

  // Add a delay for demo purposes (e.g., splash screen)
  Future.delayed(Duration(seconds: 3), () {
    if (isLoggedIn) {
      // Navigate based on user role
      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()), // Navigate to admin dashboard
        );
      } else if (role == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()), // Navigate to user main page
        );
      } else {
        // Handle unexpected role value
        print('Unknown role: $role');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // Fallback to login screen
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to login screen if not logged in
      );
    }
  });
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autologin();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PopScope(
          canPop: false,
          child: Container(
            color: Color(0xFFF7F2EF),
            // width: double.infinity,
            // height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                Image.asset("assets/images/splashicon.png"),
                Text(
                  "A LOVE NOTE FROM \n      UNIVERSE",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 50),
                Image.asset(
                  "assets/images/splash.png",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
