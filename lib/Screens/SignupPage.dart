import 'package:domifix/Screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

String? typeofuser;
String? gen;
final FirebaseAuth _auth = FirebaseAuth.instance;
final _name = TextEditingController();
final _email = TextEditingController();
final _pass = TextEditingController();
final _cpass = TextEditingController();
final _mob = TextEditingController();
final _age = TextEditingController();
final _addr = TextEditingController();
final _key = GlobalKey<FormState>();
final _userdb = FirebaseDatabase.instance.ref().child("User");
final _workerdb = FirebaseDatabase.instance.ref().child("Worker");
final _earndb = FirebaseDatabase.instance.ref().child("WorkerSavings");
final _login = FirebaseDatabase.instance.ref().child("Login");
String? uid;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final gender = ["Male", "Female"];
  final type = ["Worker", "User"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[600],
      ),
      body: SafeArea(
        child: Form(
          key: _key,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bag.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "D O M I F I X",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 215, 207, 207),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print("field empty");
                                return "Empty";
                              } else {
                                print("not empty");
                                return null;
                              }
                            },
                            controller: _name,
                            decoration: InputDecoration(
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: "  Full Name",
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print("field empty");
                                return "Empty";
                              } else {
                                print("not empty");
                                return null;
                              }
                            },
                            controller: _email,
                            decoration: InputDecoration(
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: "  Email-Address",
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print("field empty");
                                return "Empty";
                              } else {
                                print("not empty");
                                return null;
                              }
                            },
                            controller: _age,
                            decoration: InputDecoration(
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: "  Age",
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: DropdownButtonFormField(
                                hint: Text("     Gender"),
                                onChanged: (value) {
                                  print(value);
                                  gen = value;
                                },
                                items: gender.map((e) {
                                  return DropdownMenuItem(
                                      value: e, child: Text("     " + e));
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print("field empty");
                                return "Empty";
                              } else {
                                if (_mob.text.length < 10) {
                                  return "Phone Number should atleast contain 10 digits";
                                } else {
                                  return null;
                                }
                              }
                            },
                            controller: _mob,
                            decoration: InputDecoration(
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: "  Mobile Number",
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print("field empty");
                                return "Empty";
                              } else {
                                return null;
                              }
                            },
                            controller: _addr,
                            decoration: InputDecoration(
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: "  Full Address",
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          });
                                      await getlocation().then((value) async {
                                        try {
                                          GeoCode geoCode = GeoCode();
                                          Address address =
                                              await geoCode.reverseGeocoding(
                                                  latitude: value.latitude,
                                                  longitude: value.longitude);

                                          // city = address.city.toString() +
                                          //     address.region.toString() +
                                          //     address.postal.toString() +
                                          //     address.countryName.toString();

                                          print(value.latitude.toString() +
                                              "," +
                                              value.longitude.toString());
                                          print(address.city.toString() +
                                              address.region.toString() +
                                              address.postal.toString() +
                                              address.countryName.toString());

                                          _addr.text = address.streetAddress
                                                  .toString() +
                                              address.streetNumber.toString() +
                                              "," +
                                              address.city.toString() +
                                              "," +
                                              address.postal.toString() +
                                              "," +
                                              address.countryName.toString();
                                        } catch (e) {}
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.gps_fixed))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: DropdownButtonFormField(
                                hint: Text("     Register as user or worker"),
                                onChanged: (value) {
                                  print(value);
                                  typeofuser = value;
                                  print(typeofuser);
                                },
                                items: type.map((e) {
                                  return DropdownMenuItem(
                                      value: e, child: Text("     " + e));
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print("field empty");
                                return "Empty";
                              } else {
                                if (_pass.text.length < 6) {
                                  return "Password Should atleast have 6 charecter";
                                } else {
                                  return null;
                                }
                              }
                            },
                            controller: _pass,
                            decoration: InputDecoration(
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: "  Password",
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                print("field empty");
                                return "Empty";
                              } else {
                                if (_pass.text == _cpass.text) {
                                  return null;
                                } else {
                                  return "Password Missmatch";
                                }
                              }
                            },
                            controller: _cpass,
                            decoration: InputDecoration(
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText: "  Confirm password",
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      validateSignup(context);
                    },
                    icon: Icon(Icons.check),
                    label: Text(
                      "PROCEED",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[600],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateSignup(BuildContext context) async {
    if (_key.currentState!.validate()) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            });
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _cpass.text,
        );
        uid = userCredential.user!.uid;
        print("User UID: $uid");
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            print('Email is already in use');
            showErrorSnackbar(context, 'Email is already in use');
            return;
          } else {
            print('Error: ${e.message}');
          }
        } else {
          print('Error: $e');
        }
      }

      if (typeofuser == "User") {
        try {
          GeoCode geoCode = GeoCode();
          Coordinates coordinates =
              await geoCode.forwardGeocoding(address: _addr.text);

          String id = DateTime.now().millisecondsSinceEpoch.toString();
          Map<String, String> value = {
            "Id": uid.toString(),
            "Fullname": _name.text,
            "Email": _email.text,
            "Age": _age.text,
            "Gender": gen.toString(),
            "Type": typeofuser.toString(),
            "Phone": _mob.text,
            "Address": _addr.text,
            "Image":
                "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/Worker%20images%2F5907.jpg?alt=media&token=0431e7ca-e1e3-4bbb-b476-a1405c21e5d3&_gl=1*xbuvjp*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njc0MTU3Mi4zLjEuMTY5Njc0MTcwMi4zOC4wLjA.",
            "Latitude": coordinates.latitude.toString(),
            "Longitude": coordinates.longitude.toString()
          };

          await _userdb.child(uid.toString()).set(value);
          await _login.child(uid.toString()).set({"Type": "User"});
        } catch (e) {}
      } else if (typeofuser == "Worker") {
        try {
          GeoCode geoCode = GeoCode();
          Coordinates coordinates =
              await geoCode.forwardGeocoding(address: _addr.text);
          Map<String, String> value = {
            "Id": uid.toString(),
            "Fullname": _name.text,
            "Email": _email.text,
            "Age": _age.text,
            "Gender": gen.toString(),
            "Type": typeofuser.toString(),
            "Phone": _mob.text,
            "Image":
                "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/Worker%20images%2F5907.jpg?alt=media&token=0431e7ca-e1e3-4bbb-b476-a1405c21e5d3&_gl=1*xbuvjp*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njc0MTU3Mi4zLjEuMTY5Njc0MTcwMi4zOC4wLjA.",
            "About": "NULL",
            "Skill": "NULL",
            "Education": "NULL",
            "Profession": "NULL",
            "Experience": "NULL",
            "Rate": "NULL",
            "Assigned": "false",
            "Upi": "NULL",
            "Address": _addr.text,
            "Latitude": coordinates.latitude.toString(),
            "Longitude": coordinates.longitude.toString(),
            "Rating": "1"
          };

          Map<String, String> earn = {"Earnings": "0.0"};

          await _workerdb.child(uid.toString()).set(value);
          await _earndb.child(uid.toString()).set(earn);
          await _login.child(uid.toString()).set({"Type": "Worker"});
        } catch (e) {}
      }

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return LoginPage();
      }));
    }
  }

  void showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }
}

Future<Position> getlocation() async {
  await Geolocator.requestPermission().then((value) {
    print("premission accepted");
  }).onError((error, stackTrace) {
    print("Eroor");
  });
  return await Geolocator.getCurrentPosition();
}
