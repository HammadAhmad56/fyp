// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:quoteza/login.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      // Navigate to the main screen after the delay
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginScreen()), // Replace LoginScreen() with main screen
      );
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
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
    );
  }
}
