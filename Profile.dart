// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leadingWidth: 30,
          title: Text(
            "profile",
            style: GoogleFonts.nunito(),
          ),
          backgroundColor: Color(0xFFF7F2EF),
        ),
        body: Container(
          color: Color(0xFFF7F2EF),
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
                        radius: 25,
                        backgroundColor: Colors.white,
                        foregroundImage: AssetImage(
                          "assets/images/profile.png",
                        ),
                        foregroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
