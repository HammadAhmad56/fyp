import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quoteza/screens/MainPage.dart';

class AddReminders extends StatefulWidget {
  final List<Map<String, dynamic>> scheduledReminders;

  const AddReminders({Key? key, required this.scheduledReminders})
      : super(key: key);

  @override
  _AddRemindersState createState() => _AddRemindersState();
}

class _AddRemindersState extends State<AddReminders> {
  TimeOfDay? selectedTime;
  bool _isEveryday = false;
  Map<String, bool> days = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

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
    final daysOfWeek = {
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };

    for (var entry in days.entries) {
      if (entry.value) {
        int dayOffset = (daysOfWeek[entry.key]! - now.weekday) % 7;
        final scheduleDateTime = now.add(Duration(days: dayOffset)).copyWith(
              hour: selectedTime!.hour,
              minute: selectedTime!.minute,
            );

        String id = scheduleDateTime.toIso8601String(); // Generate unique ID

        await scheduleOneSignalNotification(
          appId: '1d57a855-a394-49dc-837e-cdcd2d1e0ec5',
          restApiKey: 'MDczYTE0NjUtY2Y5Ny00MzY1LTk5OGYtNTUwNDQzNGMyNjkw',
          heading: 'Quote of the day😍',
          content: quote,
          scheduleTime: scheduleDateTime,
        );

        // Add reminder with id to scheduledReminders
        widget.scheduledReminders.add({
          'id': id,
          'time': scheduleDateTime,
          'day': entry.key,
        });
      }
    }

    if (_isEveryday) {
      for (int i = 0; i < 7; i++) {
        final scheduleTime = now.add(Duration(days: i)).copyWith(
              hour: selectedTime!.hour,
              minute: selectedTime!.minute,
            );

        String id = scheduleTime.toIso8601String(); // Generate unique ID

        await scheduleOneSignalNotification(
          appId: '1d57a855-a394-49dc-837e-cdcd2d1e0ec5',
          restApiKey: 'MDczYTE0NjUtY2Y5Ny00MzY1LTk5OGYtNTUwNDQzNGMyNjkw',
          heading: 'Quote of the day😍',
          content: quote,
          scheduleTime: scheduleTime,
        );

        // Add daily reminder with id to scheduledReminders
        widget.scheduledReminders.add({
          'id': id,
          'time': scheduleTime,
          'daily': true,
        });
      }
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
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 237, 205, 207),
              Colors.white,
              Color.fromARGB(255, 247, 220, 211),
            ],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickTime,
              style: ElevatedButton.styleFrom(
                // primary: Color(0xFF2E3B4B),
                // onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                selectedTime == null
                    ? 'Pick Time'
                    : 'Time Selected: ${selectedTime!.format(context)}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: days.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: days[key],
                  onChanged: (bool? value) {
                    setState(() {
                      days[key] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _scheduleNotification,
              style: ElevatedButton.styleFrom(
                // primary: Color(0xFF2E3B4B),
                // onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                "Add Reminder",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
