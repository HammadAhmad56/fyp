// // ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/auth/Resetpassword.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = false; // Initially set to false
  void _resetPassword(BuildContext context) async {
    String email = emailController.text.trim();

    try {
      // Attempt to create a user with the email to check if it exists
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: 'temporaryPassword123!',
      );
      // If the user creation succeeds, it means the email didn't exist (which is unexpected in this context)
      // Delete the user immediately as this is not the expected behavior
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
      // Show error message as the email does not exist
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('The email address does not exist.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      if (error is FirebaseAuthException &&
          error.code == 'email-already-in-use') {
        // If email already in use, send the password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset email sent successfully.'),
          ),
        );
      } else {
        // Show error message for any other errors
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send password reset email: $error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            "Forgot Password ",
            style:
                GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Color.fromARGB(255, 247, 220, 211),
        ),
        backgroundColor: Color(0xFFF7F2EF),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 237, 205, 207),
            Colors.white,
            Color.fromARGB(255, 247, 220, 211)
          ], begin: Alignment.bottomLeft)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                          _resetPassword(context);
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
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
