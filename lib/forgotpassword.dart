// // ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/Resetpassword.dart';
import 'package:quoteza/login.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController emailController = TextEditingController();
  bool isEmailValid = false; // Initially set to false

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Forgot Password",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Text(
                    "Please Enter Your Valid E-mail Address",
                    style: GoogleFonts.nunito(color: Colors.black45),
                  ),
                ],
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    isEmailValid = isValidEmail(value);
                  });
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: isEmailValid ? null : 'Enter a valid email',
                ),
              ),
              Spacer(), // Add space between text field and button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                  foregroundColor: Colors.white,
                ),
                onPressed: isEmailValid
                    ? () {
                        // Continue button pressed with a valid email
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Reset()),
                        );
                      }
                    : null,
                child: Text(
                  'Continue',
                  style: GoogleFonts.nunito(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
