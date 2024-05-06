// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Addreminder extends StatefulWidget {
  const Addreminder({super.key});

  @override
  State<Addreminder> createState() => _AddreminderState();
}

class _AddreminderState extends State<Addreminder> {
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
            "Add Reminders",
            style: GoogleFonts.nunito(),
          ),
        ),
        body: Container(
          child: Text("Add reminder accourding to your routine "),
        ),
      ),
    );
  }
}
