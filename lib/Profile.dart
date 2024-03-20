// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/Favourites.dart';
import 'package:quoteza/Help.dart';
import 'package:quoteza/P-info.dart';
import 'package:quoteza/Privacy-policy.dart';
import 'package:quoteza/Terms.dart';
// import 'package:share_plus/share_plus.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.black, Colors.green],
                    begin: Alignment.topCenter)),
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
                            Icons.abc,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          'Subscription Plans',
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
                            Icons.abc,
                            size: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
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
                                Icons.abc,
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
                            Icons.arrow_right,
                            size: 24,
                            color: Colors.indigo.shade600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          'Share App',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        )),
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
                InkWell(
                  onTap: () {},
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
      ),
    );
  }
}
