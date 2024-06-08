// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/Favourites.dart';
import 'package:quoteza/Help.dart';
import 'package:quoteza/P-info.dart';
import 'package:quoteza/Privacy-policy.dart';
import 'package:quoteza/Reminder.dart';
import 'package:quoteza/Signup.dart';
import 'package:quoteza/Subscription.dart';
import 'package:quoteza/Terms.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quoteza/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() async {
    await _auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove("key"); //ya key email ki ha
    await prefs.remove("key2"); //ya key password ki ha
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _deleteUserAccount() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.delete();
        print('User account deleted successfully.');
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Signup()),
          );
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert", style: GoogleFonts.nunito()),
              content: Text(
                "Your Account is Deleted Successfuly",
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
      } else {
        print('No user is currently signed in.');
      }
    } catch (error) {
      print('Error deleting user account: $error');
    }
  }

  //  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _userName = '';
  late String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _userName = userData['name'] ?? 'Username not found';
        _userEmail = userData['email'] ?? 'Email not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Color(0xFFF7F2EF),
        appBar: AppBar(
          surfaceTintColor:  Color.fromARGB(255, 247, 220, 211),
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
            "profile",
            style: GoogleFonts.nunito(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
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
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage("assets/images/user.png"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _userEmail,
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  endIndent: 10,
                  indent: 10,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pinfo()),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                              Icons.person_rounded,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Profile information',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pinfo()),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black, size: 20)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                              Icons.favorite_outline_outlined,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Favourites',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black, size: 20)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Subscription()),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                              Icons.workspace_premium_outlined,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Subscription Plans',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Subscription()),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black, size: 20)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Icon(
                            shadows: [
                              Shadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                            Icons.add_alert,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Reminder()));
                        },
                        child: Text(
                          'Reminders',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.black, size: 20)),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Privacy()),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                              Icons.lock_outline_rounded,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Privacy Policy',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Privacy()),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black, size: 20)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Terms()),
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Icon(
                                shadows: [
                                  Shadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                Icons.assignment,
                                size: 24,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Terms and conditions',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Terms()),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.black, size: 20)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Help()),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                              Icons.help_outline_rounded,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Help centre',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black, size: 20)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share('Hi this is my App');
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                              Icons.share,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Share App',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            // Share.share("This is my app");
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 20,
                          )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    (showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Alert!"),
                              content:
                                  Text("Do you want to delete your account?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deleteUserAccount();
                                  },
                                  child: Text(
                                    "Yes",
                                    style:
                                        GoogleFonts.nunito(color: Colors.red),
                                  ),
                                ),
                              ],
                            )));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                              Icons.person_off_rounded,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Delete Account',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black, size: 20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Confirmation"),
                        content: Text("Do you want to Logout??"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              signOut();
                            },
                            child: Text(
                              "Yes",
                              style: GoogleFonts.nunito(color: Colors.red),
                            ),
                          ),
                        ],
                      ));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                foregroundColor: Colors.white),
            child: Text("Logout"),
          ),
        ),
      ),
    );
  }
}
