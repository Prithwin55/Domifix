import 'package:domifix/Screens/Login.dart';
import 'package:domifix/Screens/User/User.dart';
import 'package:domifix/Screens/Worker/Worker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? uidd;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "D O M I F I X",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 215, 207, 207),
          ),
        ),
      ),
    );
  }

  Future<void> checklogin(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    final sh = await SharedPreferences.getInstance();
    uidd = sh.getString("uid");
    String? x = sh.getString("login");
    if (x == "User") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) {
            return Userhome();
          },
        ),
      );
    } else if (x == "Worker") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) {
            return Worker(
              id: uidd!,
            );
          },
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return LoginPage();
      }));
    }
  }
}
