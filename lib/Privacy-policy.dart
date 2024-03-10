// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Privacy Policy",
          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7F2EF),
      ),
      backgroundColor: Color(0xFFF7F2EF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "1. Introduction:",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              'Welcome to "A Love Note From Universe." This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "2. Data Collection:",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "We may collect information about you in various ways: Directly from you when you register or use our application. Information about how you use our application. Technical data such as device information and IP addresses.",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "3. Use of Your Data:",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "Your data may be used to: Send you notifications about new features. Monitor and analyze usage patterns. Improve the application and user experience.",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "4. Data Sharing:",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "We do not sell, trade, or rent your personal information to third parties.",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "5. User Rights:",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "You can access, rectify, or erase your personal data at any time through the app's settings or by contacting our support team.",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "6. Security:",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "We take data protection seriously and use appropriate security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal data.",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "7. Updates:",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
            Text(
              "This Privacy Policy may be updated periodically. We will notify you of any significant changes.",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black87),
            ),
          ]),
        ),
      ),
    );
  }
}
