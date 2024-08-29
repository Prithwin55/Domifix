import 'package:domifix/Screens/User/homeUser.dart';
import 'package:domifix/Screens/User/map.dart';
import 'package:domifix/Screens/User/order_user.dart';
import 'package:domifix/Screens/User/profileUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:domifix/Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _auth = FirebaseAuth.instance;
final navigation = [
  userHome(),
  Orderuser(),
  //Usermap(),
  profileUser(),
];
int _nav = 0;

class Userhome extends StatefulWidget {
  const Userhome({super.key});

  @override
  State<Userhome> createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline), label: "Orders"),
          //BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _nav,
        onTap: (value) {
          print(value);
          setState(() {
            _nav = value;
          });
        },
        backgroundColor: Colors.deepPurple,
        fixedColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 26),
      ),
      body: navigation[_nav],
    );
  }
}
