// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/MainPage.dart';
import 'package:quoteza/Signup.dart';
import 'package:quoteza/forgotpassword.dart';
import 'dart:io' show Platform;

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

  Future<bool> _isAndroidDevice() async {
    if (Platform.isAndroid) {
      return true; // Return true if the device is running Android
    } else {
      return false; // Return false for all other platforms
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.top,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFF7F2EF),
            resizeToAvoidBottomInset: false,
            body: Padding(
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
                          controller: emailController,
                          validator: (value) => _validateEmail(value),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              isButtonEnabled = _isFormValid();
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) => value == null || value.isEmpty
                              ? "Password is Required"
                              : null,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: scureText,
                          onChanged: (value) {
                            setState(() {
                              isButtonEnabled = _isFormValid();
                            });
                          },
                          decoration: InputDecoration(
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
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: Text("Forgot Password?"),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                              foregroundColor: Colors.white),
                          child: Text("Login"),
                        ),
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
                                child: Text("OR"),
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
                              Text("\t\tLogin with Google"),
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
                            _showMessage(context,
                                "Apple Login is not available on Android");
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
    );
  }

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
}
