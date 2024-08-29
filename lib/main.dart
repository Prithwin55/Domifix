import 'package:domifix/Screens/Login.dart';
import 'package:domifix/Screens/SignupPage.dart';
import 'package:domifix/Screens/Splash.dart';
import 'package:domifix/Screens/User/gpay.dart';
import 'package:domifix/Screens/Worker/Worker.dart';
import 'package:domifix/Screens/Worker/buildprofile.dart';
import 'package:domifix/Screens/Worker/profileworker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences sh = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple), home: Splash());
  }
}
