import 'package:domifix/Screens/Worker/profileworker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:domifix/Screens/Splash.dart';

dynamic _data;
String _name = "";
String _age = "";
String _email = "";
String _phone = "";
String _gender = "";
String? _image;
String? _skill = "NULL";
String? _about = "NULL";
String? _education;
String? _proff;
String? _exp;
String? _assigned;
String? _rate;
String? uidd1;
String? upi;
String? addr;
final _db = FirebaseDatabase.instance.ref().child("Worker").child(uidd1!);

String? uid;
dynamic data1;
// final store = FirebaseStorage.instance.ref().child("Worker images");
// final _workerdb = FirebaseDatabase.instance.ref().child("Worker").child(uidd!);
final _key = GlobalKey<FormState>();
final years = [
  "Less than 1 Year",
  "2 Year",
  "3 Year",
  "4 Year",
  "5 Year",
  "More than 5 years"
];
String? yr = "";

final profession = [
  "Electrician",
  "Plumber",
  "Gardener",
  "Home Nurse",
  "Interior Designer"
];
String? prof = "";

// class buildprofile extends StatefulWidget {
//   buildprofile({
//     super.key,
//   });

//   @override
//   State<buildprofile> createState() => _buildprofileState();
// }

// class _buildprofileState extends State<buildprofile> {
//   @override
//   Widget build(BuildContext context) {
//     //goto();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "D O M I F I X",
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 215, 207, 207),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _key,
//           child: Container(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Text(
//                   "BUILD YOUR PROFILE",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: ListView(
//                       children: [
//                         Text(
//                           "Education / Qualification",
//                           style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               print("field empty");
//                               return "Empty";
//                             } else {
//                               print("not empty");
//                               return null;
//                             }
//                           },
//                           controller: qualif,
//                           decoration: InputDecoration(
//                               prefixIconColor: Colors.black,
//                               border: OutlineInputBorder(),
//                               hintText: data1[uid]["Education"] != null
//                                   ? data1[uid]["Education"]
//                                   : "Enter your qualifications",
//                               filled: true,
//                               fillColor: Colors.white),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "Profession",
//                           style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         DropdownButtonFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               print("field empty");
//                               return "Empty";
//                             } else {
//                               print("not empty");
//                               return null;
//                             }
//                           },
//                           value: prof,
//                           borderRadius: BorderRadius.circular(20),
//                           hint: Text("     Profession"),
//                           onChanged: (value) {
//                             print(value);
//                             prof = value;
//                           },
//                           items: profession.map((e) {
//                             return DropdownMenuItem(
//                                 value: e, child: Text("     " + e));
//                           }).toList(),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "Experience",
//                           style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         DropdownButtonFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               print("field empty");
//                               return "Empty";
//                             } else {
//                               print("not empty");
//                               return null;
//                             }
//                           },
//                           value: yr,
//                           borderRadius: BorderRadius.circular(20),
//                           hint: Text("     Years"),
//                           onChanged: (value) {
//                             print(value);
//                             yr = value;
//                           },
//                           items: years.map((e) {
//                             return DropdownMenuItem(
//                                 value: e, child: Text("     " + e));
//                           }).toList(),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "About Me",
//                           style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               print("field empty");
//                               return "Empty";
//                             } else {
//                               print("not empty");
//                               return null;
//                             }
//                           },
//                           maxLines: 8,
//                           controller: aboutme,
//                           decoration: InputDecoration(
//                               prefixIconColor: Colors.black,
//                               border: OutlineInputBorder(),
//                               hintText: "Potray yourself........",
//                               filled: true,
//                               fillColor: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: ElevatedButton.icon(
//                     onPressed: () async {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return Center(child: CircularProgressIndicator());
//                           });
//                       await updateWorker();
//                       Navigator.of(context).pop();
//                       Navigator.of(context).pop();
//                       // Navigator.pushAndRemoveUntil(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => profileWorker()),
//                       //   (route) => false,
//                       // );
//                     },
//                     icon: Icon(Icons.forward),
//                     label: Text(
//                       "FINISH",
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> updateWorker() async {
//     if (_key.currentState!.validate()) {
//       final sh = await SharedPreferences.getInstance();
//       uid = sh.getString("uid");
//       final proffdb = FirebaseDatabase.instance.ref().child(prof!).child(uid!);
//       final _workerdb =
//           FirebaseDatabase.instance.ref().child("Worker").child(uid!);
//       DatabaseEvent event = await _workerdb.once();
//       dynamic data = event.snapshot.value;

//       String name = data["Fullname"];
//       String age = data["Age"];
//       String email = data["Email"];
//       String phone = data["Phone"];
//       String gender = data["Gender"];
//       String image = data["Image"];
//       String skill = data["Skill"] != null ? data["Skill"] : "NULL";
//       String about = data["About"] != null ? data["About"] : "NULL";
//       String type = data["Type"];
//       Map<String, String> values = {
//         "Id": uidd!,
//         "Fullname": name,
//         "Email": email,
//         "Age": age,
//         "Gender": gender,
//         "Type": type,
//         "Skill": skill,
//         "Image": image,
//         "Phone": phone,
//         "Education": qualif.text,
//         "Profession": prof!,
//         "Experience": yr!,
//         "About": aboutme.text
//       };
//       _workerdb.update({"About": aboutme.text});
//       proffdb.update(values);
//     }
//   }
// }

Future<void> goto() async {
  await Future.delayed(Duration(seconds: 3));
  final store = FirebaseStorage.instance.ref().child("Worker images");
  final _workerdb = FirebaseDatabase.instance.ref().child("Worker").child(uid!);
  DatabaseEvent event = await _workerdb.once();
  data1 = event.snapshot.value;
}

class buildprofile extends StatefulWidget {
  const buildprofile({super.key});

  @override
  State<buildprofile> createState() => _buildprofileState();
}

class _buildprofileState extends State<buildprofile> {
  final qualif = TextEditingController(text: _education);

  final aboutme = TextEditingController(text: _about);
  final rate = TextEditingController(text: _rate);
  final upictrl = TextEditingController(text: upi);
  final addrctrl = TextEditingController(text: addr);

  @override
  Widget build(BuildContext context) {
    //goto();
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "BUILD YOUR PROFILE",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        Text(
                          "Education / Qualification",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("field empty");
                              return "Empty";
                            } else {
                              print("not empty");
                              return null;
                            }
                          },
                          controller: qualif,
                          decoration: InputDecoration(
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(),
                              hintText: "Enter your qualifications",
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Profession",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("field empty");
                              return "Empty";
                            } else {
                              print("not empty");
                              return null;
                            }
                          },
                          value: _assigned == "false" ? null : _proff,
                          borderRadius: BorderRadius.circular(20),
                          hint: Text("     Profession"),
                          onChanged: _assigned == "false"
                              ? (value) {
                                  print(value);
                                  prof = value.toString();
                                  // _db.update({"Assigned": "true"});
                                }
                              : null,
                          items: profession.map((e) {
                            return DropdownMenuItem(
                                value: e, child: Text("     " + e));
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Experience",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("field empty");
                              return "Empty";
                            } else {
                              print("not empty");
                              return null;
                            }
                          },
                          value: _assigned == "false" ? null : _exp,
                          borderRadius: BorderRadius.circular(20),
                          hint: Text("     Years"),
                          onChanged: (value) {
                            print(value);
                            yr = value;
                          },
                          items: years.map((e) {
                            return DropdownMenuItem(
                                value: e, child: Text("     " + e));
                          }).toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Razor id",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("field empty");
                              return "Empty";
                            } else {
                              print("not empty");
                              return null;
                            }
                          },
                          controller: upictrl,
                          decoration: InputDecoration(
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(),
                              hintText: "Enter your razor id",
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("field empty");
                              return "Empty";
                            } else {
                              print("not empty");
                              return null;
                            }
                          },
                          controller: addrctrl,
                          decoration: InputDecoration(
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(),
                              hintText: "Enter your address",
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Rate per Hour",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("field empty");
                              return "Empty";
                            } else {
                              print("not empty");
                              return null;
                            }
                          },
                          controller: rate,
                          decoration: InputDecoration(
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(),
                              hintText:
                                  "Enter your rate/hour only numbers are allowed",
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "About Me",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              print("field empty");
                              return "Empty";
                            } else {
                              print("not empty");
                              return null;
                            }
                          },
                          maxLines: 8,
                          controller: aboutme,
                          decoration: InputDecoration(
                              prefixIconColor: Colors.black,
                              border: OutlineInputBorder(),
                              hintText: "Potray yourself........",
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(child: CircularProgressIndicator());
                          });
                      await updateWorker();
                      Navigator.of(context).pop();

                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => profileWorker()),
                      //   (route) => false,
                      // );
                    },
                    icon: Icon(Icons.forward),
                    label: Text(
                      "FINISH",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateWorker() async {
    if (_key.currentState!.validate()) {
      // _db.update({"Assigned": "true"});
      final sh = await SharedPreferences.getInstance();
      uid = sh.getString("uid");
      final proffdb = FirebaseDatabase.instance.ref().child(prof!).child(uid!);
      final _workerdb =
          FirebaseDatabase.instance.ref().child("Worker").child(uid!);
      DatabaseEvent event = await _workerdb.once();
      dynamic data = event.snapshot.value;

      String name = data["Fullname"];
      String age = data["Age"];
      String email = data["Email"];
      String phone = data["Phone"];
      String gender = data["Gender"];
      String image = data["Image"];
      String skill = data["Skill"] != null ? data["Skill"] : "NULL";
      String about = data["About"] != null ? data["About"] : "NULL";
      String type = data["Type"];
      String rating = data["Rating"] != null ? data["Rating"] : "1";
      //String addr = data["Address"];
      Map<String, String> values = {
        "Id": uidd!,
        "Fullname": name,
        "Email": email,
        "Age": age,
        "Gender": gender,
        "Type": type,
        "Skill": skill,
        "Image": image,
        "Phone": phone,
        "Education": qualif.text,
        "Profession": prof!,
        "Experience": yr!,
        "Address": addrctrl.text,
        "About": aboutme.text,
        "Rate": rate.text,
        "Upi": upictrl.text,
        "Assigned": "true",
        "Rating": rating
      };
      _workerdb.update(values);
      proffdb.update(values);
      Navigator.of(context).pop();
    }
  }
}

Future<void> Fetchdatabaseforbuilder() async {
  final SharedPreferences sh = await SharedPreferences.getInstance();
  uidd1 = sh.getString("uid");
  final store = FirebaseStorage.instance.ref().child("Worker images");
  final _workerdb =
      FirebaseDatabase.instance.ref().child("Worker").child(uidd1!);
  DatabaseEvent event = await _workerdb.once();
  _data = event.snapshot.value;
  print(data);
  _name = _data["Fullname"];
  _age = _data["Age"];
  _email = _data["Email"];
  _phone = _data["Phone"];
  _gender = _data["Gender"];
  _image = _data["Image"];
  _skill = _data["Skill"];
  _about = _data["About"];
  _education = _data["Education"];
  _proff = _data["Profession"];
  prof = _data["Profession"];
  _exp = _data["Experience"];
  upi = _data["Upi"];
  yr = _exp;
  _assigned = _data["Assigned"];
  _rate = _data["Rate"];
  addr = _data["Address"];
}
