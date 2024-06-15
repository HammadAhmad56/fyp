// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();

class Pinfo extends StatefulWidget {
  const Pinfo({Key? key}) : super(key: key);
  @override
  State<Pinfo> createState() => _PinfoState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

bool _isLoading = true;

class _PinfoState extends State<Pinfo> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _fetchUserData(currentUser.uid);
    }
  }

// this will check the user is login or not if not then it will call  the clear controller fn
  void _checkCurrentUser() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _fetchUserData(currentUser.uid);
    } else {
      _clearControllers();
    }
  }

  void _clearControllers() {
    setState(() {
      nameController.clear();
      emailController.clear();
    });
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      setState(() {
        // Show loader while fetching data
        _isLoading = true;
      });
      // Fetch user document based on the provided UID
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        // If the user document exists, extract the data
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          // Update the text controllers with the fetched user data
          nameController.text = userData['name'] ?? '';
          emailController.text = userData['email'] ?? '';
          _isLoading = false;
        });
      } else {
        // Handle the case where the user document doesn't exist
        print("User document does not exist for UID: $uid");

        setState(() {
          // Hide loader when data fetch is unsuccessful
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Alert", style: GoogleFonts.nunito()),
                content: Text(
                  "User data not found 404",
                  style: GoogleFonts.nunito(),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle any errors that occur during data fetching
      print("Error fetching user data: $e");
      setState(() {
        _isLoading = false; // Hide loader when an error occurs
      });
    }
  }

  Future<void> _saveChanges() async {
    // Implement your save changes logic here
    print('Saving changes...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
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
          "Account Information",
          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Color(0xFFF7F2EF),
      body: _isLoading
          ? Container(
              width: double.infinity,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                // end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 237, 205, 207),
                  Colors.white,
                  Color.fromARGB(255, 247, 220, 211)
                ],
              )),
              child: Center(
                child: CircularProgressIndicator(), // Loader
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                // end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 237, 205, 207),
                  Colors.white,
                  Color.fromARGB(255, 247, 220, 211)
                ],
              )),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        // style: ,
                        controller: emailController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          prefixIcon: Icon(Icons.phone_android),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: _saveChanges,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                            ),
                            child: Text(
                              'Save Changes',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // if (_isLoading)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: AlertDialog(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12 ),
                      //       ),
                      //       contentPadding: EdgeInsets.zero,
                      //       actionsAlignment: MainAxisAlignment.center,surfaceTintColor: Color(0xFFF7F2EF),
                      //       backgroundColor:Color(0xFFF7F2EF),
                      //       // title: Text("Confirmation"),
                      //       // content: Text("Do you want to Logout??"),
                      //       actions: [CircularProgressIndicator()],
                      //     ), // Loader
                      //   ),

                      SizedBox(
                          height:
                              20), // Add some space at the bottom for better scrolling
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
