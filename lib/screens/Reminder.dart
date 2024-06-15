// //ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:quoteza/Addreminder.dart';
// import 'package:http/http.dart' as http;
// // String empty = "Do not have any schedule";

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
// }

// Future<void> scheduleNotification(String playerId, DateTime scheduledTime,
//     String title, String message) async {
//   final String oneSignalUrl = 'https://onesignal.com/api/v1/notifications';
//   final String appId = '1d57a855-a394-49dc-837e-cdcd2d1e0ec5';
//   final String restApiKey = 'MDczYTE0NjUtY2Y5Ny00MzY1LTk5OGYtNTUwNDQzNGMyNjkw';

//   final Map<String, dynamic> notificationData = {
//     'app_id': appId,
//     'include_player_ids': [playerId],
//     'headings': {'en': title},
//     'contents': {'en': message},
//     'send_after':
//         scheduledTime.toUtc().toIso8601String() + 'Z', // Ensure UTC time format
//   };

//   final response = await http.post(
//     Uri.parse(oneSignalUrl),
//     headers: {
//       'Content-Type': 'application/json; charset=utf-8',
//       'Authorization': 'Basic $restApiKey',
//     },
//     body: json.encode(notificationData),
//   );

//   if (response.statusCode == 200) {
//     print('Notification scheduled successfully');
//   } else {
//     print('Failed to schedule notification: ${response.body}');
//   }
// }

// // one signal get user id
// //  void _initOneSignal() async {
// //     OneSignal.shared.setAppId("YOUR_ONESIGNAL_APP_ID");
// //     OneSignal.shared.setNotificationOpenedHandler((notification) {
// //       print("Notification opened: ${notification}");
// //     });

// //     // Get the Player ID (user ID)
// //     var status = await OneSignal.shared.getDeviceState();
// //     String? playerId = status?.userId;
// //     print("OneSignal Player ID: $playerId");

// //     if (playerId != null) {
// //       // You can now use this playerId to send notifications
// //     }
// //   }

// class Reminder extends StatefulWidget {
//   const Reminder({super.key});
//   @override
//   State<Reminder> createState() => _ReminderState();
// }

// class _ReminderState extends State<Reminder> {
//   List<Map<String, dynamic>> scheduledReminders = [];
//   @override
//   void initState() {
//     super.initState();
//     // empty=scheduleDateTime.toString();
//     // _initOneSignal();
//   }

//   void _navigateToAddReminders() async {
//     final newReminder = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AddReminders()),
//     );

//     if (newReminder != null) {
//       setState(() {
//         scheduledReminders.add(newReminder);
//       });
//     }
//   }

//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Scaffold(
//         backgroundColor: Color(0xFFF7F2EF),
//         appBar: AppBar(
//           backgroundColor: Color(0xFFF7F2EF),
//           surfaceTintColor: Color(0xFFF7F2EF),
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios_new_rounded,
//               size: 20,
//             ),
//             onPressed: () {
//               Navigator.pop(
//                 context,
//               );
//             },
//           ),
//           automaticallyImplyLeading: true,
//           leadingWidth: 30,
//           title: Text(
//             "Reminders",
//             style: GoogleFonts.nunito(),
//           ),
//           actions: [
//             IconButton(
//                 onPressed: _navigateToAddReminders,
//                 icon: Icon(Icons.add_circle_outline_rounded))
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             child: Column(
//               children: [
//                 Text(
//                     'Set up daily reminders to make your motivational quotes fits your routine'),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: scheduledReminders.length,
//                     itemBuilder: (context, index) {
//                       final reminder = scheduledReminders[index];
//                       final time = reminder['time'] as DateTime;
//                       final daily = reminder['daily'] as bool;
//                       return ListTile(
//                         title: Text(
//                           "Reminder at ${time.hour}:${time.minute.toString().padLeft(2, '0')}",
//                           style: GoogleFonts.nunito(),
//                         ),
//                         subtitle: Text(
//                           daily ? "Daily" : "One-time",
//                           style: GoogleFonts.nunito(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Addreminder.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});
  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  List<Map<String, dynamic>> scheduledReminders = [];

  @override
  void initState() {
    super.initState();
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
        scheduledReminders = result;
      });
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
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
            "Reminders",
            style: GoogleFonts.nunito(),
          ),
          actions: [
            IconButton(
                onPressed: _navigateToAddReminder,
                icon: Icon(Icons.add_circle_outline_rounded))
          ],
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Set up daily reminders to make your motivational quotes fit your routine',
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: scheduledReminders.length,
                      itemBuilder: (context, index) {
                        final reminder = scheduledReminders[index];
                        final time = reminder['time'] as DateTime;
                        final daily = reminder['daily'] as bool;
                        return ListTile(
                          title: Text(
                            'Reminder ${index + 1}',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            '${time.hour}:${time.minute} - ${daily ? "Everyday" : "Once"}',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
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
      ),
    );
  }
}
