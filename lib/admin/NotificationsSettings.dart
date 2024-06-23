import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsSettingsScreenState createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  bool _inAppNotificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _ledIndicatorEnabled = false;
  String _notificationFrequency = 'Daily';
  String _timeRange = '09:00 AM - 06:00 PM';

  void _togglePushNotifications(bool value) {
    setState(() {
      _pushNotificationsEnabled = value;
    });
  }

  void _toggleEmailNotifications(bool value) {
    setState(() {
      _emailNotificationsEnabled = value;
    });
  }

  void _toggleInAppNotifications(bool value) {
    setState(() {
      _inAppNotificationsEnabled = value;
    });
  }

  void _toggleSound(bool value) {
    setState(() {
      _soundEnabled = value;
    });
  }

  void _toggleVibration(bool value) {
    setState(() {
      _vibrationEnabled = value;
    });
  }

  void _toggleLedIndicator(bool value) {
    setState(() {
      _ledIndicatorEnabled = value;
    });
  }

  void _selectNotificationFrequency(String? frequency) {
    if (frequency != null) {
      setState(() {
        _notificationFrequency = frequency;
      });
    }
  }

  void _selectTimeRange(String? timeRange) {
    if (timeRange != null) {
      setState(() {
        _timeRange = timeRange;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 220, 211),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications Settings',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Preferences',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildNotificationSwitchListTile(
              title: 'Push Notifications',
              value: _pushNotificationsEnabled,
              onChanged: _togglePushNotifications,
            ),
            _buildNotificationSwitchListTile(
              title: 'Email Notifications',
              value: _emailNotificationsEnabled,
              onChanged: _toggleEmailNotifications,
            ),
            _buildNotificationSwitchListTile(
              title: 'In-App Notifications',
              value: _inAppNotificationsEnabled,
              onChanged: _toggleInAppNotifications,
            ),
            SizedBox(height: 30),
            Text(
              'Notification Settings',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Notification Sound'),
              trailing: Switch(
                value: _soundEnabled,
                onChanged: _toggleSound,
              ),
            ),
            ListTile(
              title: Text('Vibration'),
              trailing: Switch(
                value: _vibrationEnabled,
                onChanged: _toggleVibration,
              ),
            ),
            ListTile(
              title: Text('LED Indicator'),
              trailing: Switch(
                value: _ledIndicatorEnabled,
                onChanged: _toggleLedIndicator,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Advanced Settings',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Notification Frequency'),
              trailing: DropdownButton<String>(
                value: _notificationFrequency,
                onChanged: _selectNotificationFrequency,
                items:
                    <String>['Daily', 'Weekly', 'Monthly'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: Text('Time Range'),
              trailing: DropdownButton<String>(
                value: _timeRange,
                onChanged: _selectTimeRange,
                items: <String>[
                  '08:00 AM - 05:00 PM',
                  '09:00 AM - 06:00 PM',
                  '10:00 AM - 07:00 PM'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationsSettingsScreen(),
  ));
}
