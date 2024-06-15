// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/auth/login.dart';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool scureText = true;
  bool confirmscureText = true;
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _validateName(String? value) {
    return value == null || value.isEmpty ? 'Name is required' : null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != _password) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool _isFormValid() {
    return _formKey.currentState?.validate() ?? false;
  }

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

  Future<void> registeruser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.toString(),
          password: _password.toString(),
        );
        // User created successfully
        User? user = userCredential.user;
        print('User created: ${user?.uid}');
        user!.displayName;
        await _saveUserData(user.uid.toString());
        // _saveUserData(user!.uid.toString());
        // Navigate to login screen after successful signup
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } catch (e) {
        print('Failed to create user: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create user. Please try again.'),
          ),
        );
      }
    }
  }

  final _auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _saveUserData(String uid) async {
    try {
      // Reference to the document using the UID
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

      // Create or update the document with the specified UID and user data
      await userDocRef.set({
        'name': _name, // Example data from your form fields
        'email': _email, // Example data from your form fields
      });

      print('User data saved successfully with UID: $uid');
    } catch (error) {
      print('Error saving user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF7F2EF),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 237, 205, 207),
            Colors.white,
            Color.fromARGB(255, 247, 220, 211)
          ], begin: Alignment.bottomLeft)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Create your account",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter your personal information",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) => _name = value.trim(),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: _validateName,
                      onSaved: (value) => _name = value!,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) => _email = value.trim(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => _validateEmail(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) => _password = value,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: scureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            scureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              scureText = !scureText;
                            });
                          },
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.key_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is Required";
                        }
                        if (_validatePassword(value) != null) {
                          return _validatePassword(value);
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) =>
                          _validateConfirmPassword(value, _password),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: confirmscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            confirmscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              confirmscureText = !confirmscureText;
                            });
                          },
                        ),
                        hintText: "Confirm Password",
                        prefixIcon: Icon(Icons.key_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isFormValid()
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  registeruser(); // Call _registerUser function if form is valid
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Signup"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
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
                    ),
                    SizedBox(
                      height: 12,
                    ),
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
                    SizedBox(height: 13),
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
                            Icon(Icons.apple_rounded),
                            Text("\t\tLogin with Apple"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
