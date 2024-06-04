import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:quoteza/MainPage.dart';
import 'package:quoteza/Reminder.dart';

TimeOfDay? selectedTime;
final now = DateTime.now();
final scheduleDateTime = DateTime(
  now.year,
  now.month,
  now.day,
  selectedTime!.hour,
  selectedTime!.minute,
);

class AddReminders extends StatefulWidget {
  @override
  _AddRemindersState createState() => _AddRemindersState();
}

class _AddRemindersState extends State<AddReminders> {
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
        empty = selectedTime.toString();
      });
    }
  }

  void _scheduleNotification() {
    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a time first')),
      );
      return;
    }

    scheduleOneSignalNotification(
      appId: '1d57a855-a394-49dc-837e-cdcd2d1e0ec5',
      restApiKey: 'MDczYTE0NjUtY2Y5Ny00MzY1LTk5OGYtNTUwNDQzNGMyNjkw',
      heading: 'Quote of the day😍',
      content: quote,
      scheduleTime: scheduleDateTime, // Schedule 1 minute from now
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OneSignal Example"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _pickTime,
              child: Text("Pick Time"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleNotification,
              child: Text("Schedule Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
