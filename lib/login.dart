// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/MainPage.dart';
import 'package:quoteza/Signup.dart';
import 'package:quoteza/forgotpassword.dart';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool scureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;
  String? emailError;
  String? passwordError;

  Future<bool> _isAndroidDevice() async {
    if (Platform.isAndroid) {
      return true; // Return true if the device is running Android
    } else {
      return false; // Return false for all other platforms
    }
  }

  // this is the velidation of email and password textboxs
  bool _isFormValid() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        _validateEmail(emailController.text) == null &&
        _validatePassword(passwordController.text) == null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Your email validation logic goes here
    // For example, you can use a regular expression for a basic email validation
    // Replace the regular expression below with a more comprehensive one if needed
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // Your password validation logic goes here
    // For example, you can check if the password has a minimum length
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // end of the velidation of email and passwords textboxs
// ya wala message snackbar ka ha jis ma apple ki button ma show ho rha ha
  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(
            "Apple Login is not available on andriod device ",
            style: GoogleFonts.nunito(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool isLoading = false;
  // bool isButtonEnabled = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signInWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
      isButtonEnabled = false;
      emailError = null;
      passwordError = null;
    });
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        prefs.setString("Key", email);
        prefs.setString("key2", password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        // Navigate to another screen after successful login
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AnotherScreen()));
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Failed to Login",
              style: GoogleFonts.nunito(),
            ),
            content: Text(
              "Invalid Email or password",
              style: GoogleFonts.nunito(),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "OK",
                  style: GoogleFonts.nunito(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print('Error signing in: $e');
      // Handle sign-in errors here
    } finally {
      setState(() {
        isLoading = false;
        isButtonEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.top,
        child: SafeArea(
          child: Scaffold(
            // backgroundColor: Color(0xFFF7F2EF),
            resizeToAvoidBottomInset: false,
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Color.fromARGB(255, 237, 205, 207),
            Colors.white,
            Color.fromARGB(255, 247, 220, 211)
              ], begin: Alignment.bottomLeft)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            "Login to your account",
                            style: GoogleFonts.nunito(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            child: Text(
                          "Enter Your Login Information",
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            style: GoogleFonts.nunito(),
                            onChanged: (value) {
                              setState(() {
                                isButtonEnabled = _isFormValid();
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Email",
                                errorText: _validateEmail(emailController.text),
                                prefixIcon: Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            controller: emailController,
                            validator: (value) => _validateEmail(value),
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            style: GoogleFonts.nunito(),
                            onChanged: (value) {
                              setState(() {
                                isButtonEnabled = _isFormValid();
                              });
                            },
                            decoration: InputDecoration(
                                errorText:
                                    _validatePassword(passwordController.text),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    scureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      scureText = !scureText; //eye button logic
                                    });
                                  },
                                ),
                                hintText: "Password",
                                prefixIcon: Icon(Icons.key_rounded),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            controller: passwordController,
                            validator: (value) => value == null || value.isEmpty
                                ? "Password is Required"
                                : null,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: scureText,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.nunito(),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Forgot()),
                                );
                              },
                            )),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(9),
                          child: ElevatedButton(
                            onPressed: isButtonEnabled
                                ? () {
                                    signInWithEmailAndPassword();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              "Login",
                              style: GoogleFonts.nunito(),
                            ),
                          ),
                        ),
                        if (isLoading)
                          Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                        Container(
                            height: 20,
                            // color: Colors.red,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "OR",
                                    style: GoogleFonts.nunito(),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(height: 12),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromRGBO(46, 59, 75, 1),
                                width: 1.5,
                              ),
                            ),
                            height: 60,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  "\t\tLogin with Google",
                                  style: GoogleFonts.nunito(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        InkWell(
                          onTap: () async {
                            if (await _isAndroidDevice()) {
                              _showMessage(
                                context,
                                "Apple Login is not available on Android",
                              );
                            } else {}
                            ;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromRGBO(46, 59, 75, 1),
                                width: 1.5,
                              ),
                            ),
                            height: 60,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.apple_rounded,
                                  size: 32,
                                ),
                                Text("\t\tLogin with Apple"),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?",
                                  style: GoogleFonts.nunito(
                                    color: Colors.black,
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()),
                                    );
                                  },
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
