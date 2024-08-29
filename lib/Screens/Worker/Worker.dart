import 'package:domifix/Screens/Login.dart';
import 'package:domifix/Screens/Worker/homeworker.dart';
import 'package:domifix/Screens/Worker/order_worker.dart';
import 'package:domifix/Screens/Worker/profileworker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

int _nav = 0;
String id = "not fond";
final navScreen = [
  homeWorker(
    id: id!,
  ),
  Orderworker(),
  profileWorker()
];

class Worker extends StatefulWidget {
  String id;
  Worker({required this.id});
  @override
  State<Worker> createState() => _UserhomeState();
}

class _UserhomeState extends State<Worker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "D O M I F I X",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 215, 207, 207),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                _auth.signOut().then((value) async {
                  final sh = await SharedPreferences.getInstance();
                  sh.setString("login", "Null");
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return LoginPage();
                  }));
                });
              },
              icon: Icon(Icons.logout_sharp))
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        currentIndex: _nav,
        onTap: (value) {
          print(value);

          setState(() {
            id = widget.id;
            // print(widget.id);

            _nav = value;
          });
        },
        backgroundColor: Colors.deepPurple,
        fixedColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 26),
      ),
      body: navScreen[_nav],
    );
  }
}
