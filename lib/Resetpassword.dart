// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/forgotpassword.dart';
// import 'package:pin_input_text_field/pin_input_text_field.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  String pin = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Color(0xFFF7F2EF),
          leading: IconButton(
            icon: const Icon(
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
            "Reset Password",
            style:
                GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Color(0xFFF7F2EF),
        ),
        backgroundColor: Color(0xFFF7F2EF),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Column(children: [
              Text(
                "Please check your email. Enter the forwarded code below.",
                style: GoogleFonts.nunito(color: Colors.black),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
