// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/MainPage.dart';
import 'package:quoteza/Signup.dart';
import 'package:quoteza/forgotpassword.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF7F2EF),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                            scureText ? Icons.visibility : Icons.visibility_off,
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
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => Forgot()),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(
                        height: 1,
                        // color: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Divider(
                        height: 1,
                        // color: Colors.green,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromRGBO(46, 59, 75, 1),
                        width: 1.5,
                      ),
                    ),
                    height: 66,
                    child: Row(
                      children: [
                        Image.asset("assets/images/google.png"),
                        Text("\tLogin with Google"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromRGBO(46, 59, 75, 1),
                        width: 1.5,
                      ),
                    ),
                    height: 66,
                    child: Row(
                      children: [
                        Image.asset("assets/images/apple.png"),
                        Text("\tLogin with Apple"),
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
                              MaterialPageRoute(builder: (context) => Signup()),
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
