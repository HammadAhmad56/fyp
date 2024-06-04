// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/Favourites.dart';
import 'package:quoteza/Help.dart';
import 'package:quoteza/P-info.dart';
import 'package:quoteza/Privacy-policy.dart';
import 'package:quoteza/Reminder.dart';
import 'package:quoteza/Signup.dart';
import 'package:quoteza/Subscription.dart';
import 'package:quoteza/Terms.dart';
import 'package:quoteza/Addreminder.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quoteza/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    await prefs.remove("key");//ya key email ki ha 
    await prefs.remove("key2");//ya key password ki ha
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // delete user fn
  // void _deleteUserAccount() async {
  //   try {
  //     User? user = _auth.currentUser;

  //     if (user != null) {
  //       // Re-authenticate the user
  //       String email = user.email!;
  //       String password = 'userPassword'; // Replace with the user's password

  //       AuthCredential credential =
  //           EmailAuthProvider.credential(email: email, password: password);
  //       await user.reauthenticateWithCredential(credential);

  //       await user.delete();
  //       print('User account deleted successfully.');
  //     } else {
  //       print('No user is currently signed in.');
  //     }
  //   } catch (error) {
  //     print('Error deleting user account: $error');
  //   }
  // }
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Your Account is deleted successfully!'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        print('No user is currently signed in.');
      }
    } catch (error) {
      print('Error deleting user account: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Color(0xFFF7F2EF),
        appBar: AppBar(
          backgroundColor: Color(0xFFF7F2EF),
          surfaceTintColor: Color(0xFFF7F2EF),
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
                gradient: LinearGradient(colors: [
              Color(0xFFF7F2EF),
              Colors.white,
              Color(0xFFF7F2EF)
            ], begin: Alignment.bottomLeft)),
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
                            "Emily John",
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "emily.john@gmail.com",
                            style: GoogleFonts.nunito(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
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
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
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
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
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
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
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
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Icon(
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
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
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
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Icon(
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
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
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
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
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
                              title: Text("Aleart!"),
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
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Icon(
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
