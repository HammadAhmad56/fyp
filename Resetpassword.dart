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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(children: [
              Container(
                  child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context,
                            MaterialPageRoute(builder: (context) => Forgot()));
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  Text(
                    "Reset Password",
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ],
              )),
              Container(
                child: Column(children: [
                  Text(
                    "Please check your email. Enter the forwarded code below.",
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
