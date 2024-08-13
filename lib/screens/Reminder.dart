// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:async'; // Import the Timer class
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoteza/screens/Addreminder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'SharedPreferencesViewer.dart';

class Reminder extends StatefulWidget {
  const Reminder({Key? key}) : super(key: key);

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  List<Map<String, dynamic>> scheduledReminders = [];
  final String _prefsKey = 'reminders';
  bool _isLoading = true;
  Timer? _reminderTimer;

  @override
  void initState() {
    super.initState();
    _loadRemindersFromPrefs();
    _startReminderTimer();
  }

  @override
  void dispose() {
    _reminderTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadRemindersFromPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? remindersJson = prefs.getString(_prefsKey);
      if (remindersJson != null) {
        List<dynamic> parsedJson = jsonDecode(remindersJson);
        List<Map<String, dynamic>> reminders = parsedJson.map((json) {
          DateTime time = DateTime.parse(json['time']);
          bool daily = json['daily'] ?? false;
          String day = json['day'] ?? '';
          return {
            'time': time,
            'daily': daily,
            'day': day,
            'id': json['id'],
          };
        }).toList();
        setState(() {
          scheduledReminders = reminders;
        });
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading reminders: $e');
    }
  }

  Future<void> _saveRemindersToPrefs(
      List<Map<String, dynamic>> reminders) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> serializedReminders =
          reminders.map((reminder) {
        DateTime time = reminder['time'];
        String formattedTime = time.toIso8601String();
        return {
          'time': formattedTime,
          'daily': reminder['daily'],
          'day': reminder['day'],
          'id': reminder['id'],
        };
      }).toList();
      String remindersJson = jsonEncode(serializedReminders);
      await prefs.setString(_prefsKey, remindersJson);
    } catch (e) {
      print('Error saving reminders: $e');
    }
  }

  Future<void> cancelOneSignalNotification(String notificationId) async {
    try {
      final url = Uri.parse(
          'https://onesignal.com/api/v1/notifications/$notificationId?app_id=1d57a855-a394-49dc-837e-cdcd2d1e0ec5');
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Basic MDczYTE0NjUtY2Y5Ny00MzY1LTk5OGYtNTUwNDQzNGMyNjkw',
      };

      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('Notification cancelled successfully');
      } else {
        print('Failed to cancel notification: ${response.body}');
      }
    } catch (e) {
      print('Error cancelling notification: $e');
    }
  }

  void _removeReminderFromList(Map<String, dynamic>? reminder) {
    if (reminder == null || reminder['id'] == null) {
      print('Reminder or its ID is null, cannot remove');
      return;
    }

    // Ensure 'id' is treated as a string
    String id = reminder['id'].toString();

    setState(() {
      // Remove the reminder where its 'id' matches
      scheduledReminders.removeWhere((element) => element['id'] == id);
    });

    // Save updated reminders to preferences
    _saveRemindersToPrefs(scheduledReminders);
  }

  void _navigateToAddReminder() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReminders(
          scheduledReminders: List.from(scheduledReminders),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        scheduledReminders = List<Map<String, dynamic>>.from(result);
      });
      await _saveRemindersToPrefs(scheduledReminders);
    }
  }

  void _startReminderTimer() {
    _reminderTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      _removeExpiredReminders();
    });
  }

  void _removeExpiredReminders() {
    final now = DateTime.now();
    setState(() {
      scheduledReminders.removeWhere((reminder) {
        final time = reminder['time'] as DateTime?;
        return time != null && time.isBefore(now);
      });
      _saveRemindersToPrefs(scheduledReminders);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
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
        title: Text(
          "Reminders",
          style: GoogleFonts.nunito(),
        ),
        actions: [
          IconButton(
            onPressed: _navigateToAddReminder,
            icon: Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Set up daily reminders to make your motivational quotes fit your routine',
                      ),
                      SizedBox(height: 20),
                      scheduledReminders.isEmpty
                          ? Center(
                              child: Text(
                                'No reminders set',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: scheduledReminders.length,
                                itemBuilder: (context, index) {
                                  final reminder = scheduledReminders[index];
                                  final time = reminder['time'] as DateTime?;
                                  final daily = reminder['daily'] as bool?;
                                  final day = reminder['day'] as String?;
                                  return ListTile(
                                    title: Text(
                                      'Reminder ${index + 1}',
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${time?.hour ?? 0}:${time?.minute ?? 0} - ${daily == true ? "Everyday" : (day ?? "N/A")}',
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_outline_rounded),
                                      onPressed: () {
                                        _removeReminderFromList(reminder);
                                      },
                                    ),
                                  );
                                },
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
