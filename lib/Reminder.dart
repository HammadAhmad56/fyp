//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:quoteza/Addreminder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Alarm.init();
}

class Reminder extends StatefulWidget {
  const Reminder({super.key});
  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
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
            "Reminders",
            style: GoogleFonts.nunito(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addreminder()));
                },
                icon: Icon(Icons.add_circle_outline_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Text(
                    'Set up daily reminders to make your motivational quotes fits your routine')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
