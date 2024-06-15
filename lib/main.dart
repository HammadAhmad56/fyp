// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quoteza/admin/Dashboard.dart';
import 'screens/P-info.dart';
import 'screens/Splashscreen.dart';
import 'screens/Fquote.dart';
import 'screens/MainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quoteza/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stripe with your publishable key
  // Stripe.publishableKey =
  //     "pk_test_51PPjIS2L9yyHmmzwVaK6GETJylZxloBOVtA7tpnJFvrP66aSnPgyCNJphE2xVYuoy5CwiLFI4KbNBPHlwbupt4cl00bFF3GsiR";
  // Stripe.instance.applySettings();
  // initialize firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCfljHxn4iQ-tyeG3amJCLM1G4I9mrSL8Y',
      appId: '1:1008830126267:android:b9c78e2e70bf57406df19e',
      messagingSenderId: 'sendid',
      projectId: 'quoteza-d0043',
      storageBucket: 'quoteza-d0043.appspot.com',
    ),
  );
// one signal
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("1d57a855-a394-49dc-837e-cdcd2d1e0ec5");
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF7F2EF),
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
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
        home: Dashboard(),
      ),
    );
  }
}
