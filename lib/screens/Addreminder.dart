// // ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MainPage.dart';

class AddReminders extends StatefulWidget {
  final List<Map<String, dynamic>> scheduledReminders;
  const AddReminders({super.key, required this.scheduledReminders});

  @override
  _AddRemindersState createState() => _AddRemindersState();
}

class _AddRemindersState extends State<AddReminders> {
  TimeOfDay? selectedTime;
  bool _isEveryday = false;

  Future<void> scheduleOneSignalNotification({
    required String appId,
    required String restApiKey,
    required String heading,
    required String content,
    required DateTime scheduleTime,
  }) async {
    final url = Uri.parse('https://onesignal.com/api/v1/notifications');
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Basic $restApiKey',
    };
    final body = jsonEncode({
      'app_id': appId,
      'headings': {'en': heading},
      'contents': {'en': content},
      'send_after': scheduleTime.toUtc().toIso8601String(),
      'included_segments': ['All'],
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Notification scheduled successfully');
    } else {
      print('Failed to schedule notification: ${response.body}');
    }
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _scheduleNotification() async {
    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a time first')),
      );
      return;
    }

    final now = DateTime.now();
    final scheduleDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    if (_isEveryday) {
      for (int i = 0; i < 7; i++) {
        final scheduleTime = scheduleDateTime.add(Duration(days: i));
        await scheduleOneSignalNotification(
          appId: '1d57a855-a394-49dc-837e-cdcd2d1e0ec5',
          restApiKey: 'MDczYTE0NjUtY2Y5Ny00MzY1LTk5OGYtNTUwNDQzNGMyNjkw',
          heading: 'Quote of the day😍',
          content: quote,
          scheduleTime: scheduleTime,
        );
        widget.scheduledReminders.add({
          'time': scheduleTime,
          'daily': true,
        });
      }
    } else {
      await scheduleOneSignalNotification(
        appId: '1d57a855-a394-49dc-837e-cdcd2d1e0ec5',
        restApiKey: 'MDczYTE0NjUtY2Y5Ny00MzY1LTk5OGYtNTUwNDQzNGMyNjkw',
        heading: 'Quote of the day😍',
        content: quote,
        scheduleTime: scheduleDateTime,
      );
      widget.scheduledReminders.add({
        'time': scheduleDateTime,
        'daily': false,
      });
    }
    Navigator.pop(context, widget.scheduledReminders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Reminders",
          style: GoogleFonts.nunito(),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true,
        leadingWidth: 30,
                  backgroundColor:Color.fromARGB(255, 247, 220, 211),
      ),
      body: Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _pickTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                  foregroundColor: Colors.white,
                ),
                child: Text("Pick Time"),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text("Everyday"),
                value: _isEveryday,
                onChanged: (bool? value) {
                  setState(() {
                    _isEveryday = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _scheduleNotification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(46, 59, 75, 1),
                  foregroundColor: Colors.white,
                ),
                child: Text("Add Reminders"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
