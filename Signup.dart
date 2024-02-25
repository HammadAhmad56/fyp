// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/login.dart';

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

  String? _validateConfirmPassword(String? value) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF7F2EF),
        body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
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
                    validator: _validateName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) => _email = value.trim(),
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) => _password = value,
                    validator: _validatePassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: scureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          scureText ? Icons.visibility : Icons.visibility_off,
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
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: _validateConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: confirmscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          confirmscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Signup"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Divider(height: 1),
                      Text("or"),
                      Divider(),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
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
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromRGBO(46, 59, 75, 1),
                          width: 1.5,
                        ),
                      ),
                      height: 66,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/apple.png",
                            height: 29,
                            width: 30,
                          ),
                          Text("\tLogin with Apple"),
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
    );
  }
}
