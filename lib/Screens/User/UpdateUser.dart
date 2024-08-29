import 'dart:io';

import 'package:flutter/material.dart';
import 'package:domifix/Screens/Login.dart';
import 'package:domifix/Screens/Worker/buildprofile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domifix/Screens/Splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

File? selectedImage;
// final store = FirebaseStorage.instance.ref().child("Worker images");
// final _workerdb = FirebaseDatabase.instance.ref().child("Worker").child(uidd!);
String? uid;
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
String education = "";
String proff = "";
String addr = "";

class updateUser extends StatefulWidget {
  const updateUser({super.key});

  @override
  State<updateUser> createState() => _updateUserState();
}

class _updateUserState extends State<updateUser> {
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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: image != null
                          ? NetworkImage(image!)
                          : NetworkImage(url),
                      radius: 75,
                    ),
                    onTap: () {
                      _pickImageFromGallery();
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text("Name"),
                subtitle: Text(name),
                leading: Icon(Icons.person),
                trailing: IconButton(
                    onPressed: () {
                      edit(context, name, "Fullname");
                    },
                    icon: Icon(Icons.edit)),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                title: Text("Age"),
                subtitle: Text(age),
                leading: Icon(Icons.person),
                trailing: IconButton(
                  onPressed: () {
                    edit(context, age, "Age");
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                title: Text("E-mail"),
                subtitle: Text(email),
                leading: Icon(Icons.person),
                trailing: IconButton(
                    onPressed: () {
                      edit(context, email, "Email");
                    },
                    icon: Icon(Icons.edit)),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                title: Text("Phone"),
                subtitle: Text(phone),
                leading: Icon(Icons.person),
                trailing: IconButton(
                    onPressed: () {
                      edit(context, phone, "Phone");
                    },
                    icon: Icon(Icons.edit)),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                title: Text("Gender"),
                subtitle: Text(gender),
                leading: Icon(Icons.person),
                trailing: IconButton(
                  onPressed: () {
                    edit(context, gender, "Gender");
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final SharedPreferences sh = await SharedPreferences.getInstance();
    String? uidd = sh.getString("uid");
    final store = FirebaseStorage.instance.ref().child("User images");
    final _workerdb =
        FirebaseDatabase.instance.ref().child("User").child(uidd!);
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
      print(selectedImage);
      if (selectedImage == null)
        return;
      else {
        try {
          Reference fileChild = await store.child(uidd!);
          await fileChild.putFile(selectedImage!);

          url = await fileChild.getDownloadURL();

          print("url" + url);
          _workerdb.update({"Image": url.toString()});
          setState(() {});
        } catch (e) {}
      }
    } else {
      print("no image selected");
      // User canceled the image selection
    }
  }

  final ctrl = TextEditingController();
  Future<void> edit(BuildContext context, String item, String type) async {
    print("hai");

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          print("hello");
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: ctrl,
                decoration: InputDecoration(
                    hintText: item,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                onPressed: () async {
                  final SharedPreferences sh =
                      await SharedPreferences.getInstance();
                  String? uidd = sh.getString("uid");
                  final store =
                      FirebaseStorage.instance.ref().child("Worker images");
                  final _workerdb = FirebaseDatabase.instance
                      .ref()
                      .child("User")
                      .child(uidd!);
                  _workerdb..update({type: ctrl.text.toString()});
                  await Fetchdatabase();
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text("Update"),
              )
            ],
          );
        });
  }

  Future<void> editAbout(BuildContext context, String item, String type) async {
    print("hai");
    final sh = await SharedPreferences.getInstance();
    String? uidd = sh.getString("uid");

    final _workerdb =
        FirebaseDatabase.instance.ref().child("Worker").child(uidd!);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          print("hello");
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                maxLines: 7,
                controller: ctrl,
                decoration: InputDecoration(
                    hintText: item,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                onPressed: () async {
                  _workerdb..update({type: ctrl.text.toString()});
                  await Fetchdatabase();
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text("Update"),
              )
            ],
          );
        });
  }
}

Future<void> Fetchdatabase() async {
  final SharedPreferences sh = await SharedPreferences.getInstance();
  String? uidd = sh.getString("uid");
  final store = FirebaseStorage.instance.ref().child("User images");
  final _workerdb = FirebaseDatabase.instance.ref().child("User").child(uidd!);
  DatabaseEvent event = await _workerdb.once();
  data = event.snapshot.value;
  print(data);
  name = data["Fullname"];
  age = data["Age"];
  email = data["Email"];
  phone = data["Phone"];
  gender = data["Gender"];
  image = data["Image"];
  addr = data["Address"];
}
