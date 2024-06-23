// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field
import 'dart:ui';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/auth/login.dart';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRemoveuser extends StatefulWidget {
  const AddRemoveuser({Key? key}) : super(key: key);
  @override
  State<AddRemoveuser> createState() => _AddRemoveuserState();
}

class _AddRemoveuserState extends State<AddRemoveuser> {
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
        // Navigate to login screen after successful AddRemoveuser
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Information'),
            content: Text('User Added Successfully'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
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

  //********************************* start of the delete user login */
  // final TextEditingController _emailController = TextEditingController();
  // void removeUser(String emailOrUid) async {
  //   // Implement your Firebase user removal logic here

  //   try {
  //     // Determine if input is an email or UID
  //     User? user;
  //     if (emailOrUid.contains('@')) {
  //       // If input is email, fetch user by email

  //       var result =
  //           await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailOrUid);
  //       if (result.isEmpty) {
  //         // User does not exist with this email
  //         showDialog(
  //           context: context,
  //           builder: (context) => AlertDialog(
  //             title: Text('User Not Found'),
  //             content: Text('No user found with this email.'),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //         return;
  //       }
  //       user = FirebaseAuth.instance.currentUser;
  //     } else {
  //       // If input is UID, fetch user by UID
  //       user = await FirebaseAuth.instance.currentUser!;
  //       user.delete();
  //     }

  //     // Delete the user
  //     await user!.delete();

  //     // Show success message
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('User Removed'),
  //         content: Text('User removed successfully.'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     // Show error message if user removal fails
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Error'),
  //         content: Text('Failed to remove user: $e'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
  final TextEditingController _emailController = TextEditingController();
  void removeUser(String emailOrUid) async {
    try {
      final HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('deleteUser');
      final response = await callable.call(<String, dynamic>{
        'emailOrUid': emailOrUid,
      });

      if (response.data['success'] == true) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('User Removed'),
            content: Text('User removed successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to remove user: ${response.data['error']}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to remove user: $e'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  //********************************* end of the delete user login */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Color.fromARGB(255, 247, 220, 211),
          backgroundColor: Color.fromARGB(255, 247, 220, 211),
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
            "Add Remove Users",
            style: GoogleFonts.nunito(),
          ),
        ),
        // resizeToAvoidBottomInset: false,
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
                    Text("Enter the information to add users",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
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
                        child: Text("Add User"),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Enter the information to remove users",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email or UID",
                        prefixIcon: Icon(Icons.person_remove_alt_1_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Alert‼"),
                                    content: Text(
                                        "Do you want to remove the user!?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          removeUser(
                                              _emailController.text.trim());
                                        },
                                        child: Text(
                                          "Yes",
                                          style: GoogleFonts.nunito(
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Remove User'),
                      ),
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
