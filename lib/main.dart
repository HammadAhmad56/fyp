// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quoteza/P-info.dart';
import 'package:quoteza/Splashscreen.dart';
import 'Fquote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quoteza/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quoteza/MainPage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyCfljHxn4iQ-tyeG3amJCLM1G4I9mrSL8Y',
    appId: '1:1008830126267:android:b9c78e2e70bf57406df19e',
    messagingSenderId: 'sendid',
    projectId: 'quoteza-d0043',
    storageBucket: 'quoteza-d0043.appspot.com',
  )
      // options: DefaultFirebaseOptions.currentPlatform
      );

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("1d57a855-a394-49dc-837e-cdcd2d1e0ec5");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF7F2EF),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


@override
void initState() {
  nameController;
  emailController;
}


class _MyAppState extends State<MyApp> {
  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteQuotes(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF7F2EF)),
          primaryColor: Color(0xFFF7F2EF),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
