import 'package:domifix/Screens/User/UpdateUser.dart';
import 'package:flutter/material.dart';
import 'dart:io';
//import 'package:domifix/Screens/Login.dart';
// import 'package:domifix/Screens/Splash.dart';
import 'package:domifix/Animation/temp.dart';
import 'package:domifix/Screens/Login.dart';
import 'package:domifix/Screens/Worker/Worker.dart';
import 'package:domifix/Screens/Worker/buildprofile.dart';
import 'package:domifix/Screens/Worker/order_worker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domifix/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

File? selectedImage;
String? userid = "Not assigned";
// final store = FirebaseStorage.instance.ref().child("Worker images");
// final _workerdb = FirebaseDatabase.instance.ref().child("Worker").child(uidd!);

String url =
    "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/Worker%20images%2F5907.jpg?alt=media&token=0431e7ca-e1e3-4bbb-b476-a1405c21e5d3&_gl=1*xbuvjp*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njc0MTU3Mi4zLjEuMTY5Njc0MTcwMi4zOC4wLjA.";
dynamic data;
String name = "";
String age = "";
String email = "";
String phone = "";
String gender = "";
String? image;
String? skill = "NULL";
String? about = "NULL";

class profileUser extends StatefulWidget {
  const profileUser({super.key});

  @override
  State<profileUser> createState() => _profileUserState();
}

class _profileUserState extends State<profileUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            backgroundImage:
                image != null ? NetworkImage(image!) : NetworkImage(url),
            radius: 70,
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.person_4),
            title: Text("My Profile"),
            onTap: () async {
              // final SharedPreferences sh =
              //     await SharedPreferences.getInstance();
              // String? uid = sh.getString("uid");
              showDialog(
                context: context,
                barrierDismissible:
                    false, // Prevent dialog from closing on tap outside
                builder: (context) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 100, // Adjust the size as needed (smaller)
                    ),
                  );
                },
              );
              await Fetchdatabase();
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return updateUser();
              }));
            },
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text("My Address"),
            onTap: () {
              Address();
            },
          ),
          Divider(
            thickness: 2,
          ),
        ]),
      ),
    );
  }

  Future<void> Address() async {
    final SharedPreferences sh = await SharedPreferences.getInstance();
    userid = sh.getString("uid")!;
    final _wrkdb = FirebaseDatabase.instance.ref().child("User").child(userid!);
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing on tap outside
      builder: (context) {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.white,
            size: 100, // Adjust the size as needed (smaller)
          ),
        );
      },
    );
    DatabaseEvent data = await _wrkdb.once();
    dynamic datah = data.snapshot.value;
    String add = datah["Address"];
    Navigator.of(context).pop();
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              "ADDRESS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: 350,
              height: 100,
              child: Center(
                  child: Text(
                add,
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              )),
            ),
          );
        });
  }
}
