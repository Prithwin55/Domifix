import 'package:domifix/Screens/SignupPage.dart';
import 'package:domifix/Screens/User/User.dart';
import 'package:domifix/Screens/Worker/Worker.dart';
import 'package:domifix/Screens/Splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final _login = FirebaseDatabase.instance.ref().child("Login");
final _email = TextEditingController();
final _pass = TextEditingController();
String? uid;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bag.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "D O M I F I X",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 215, 207, 207),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            hintText: "E-mail Address",
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _pass,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_email.text != "" && _pass.text != "") {
                            login(_email.text, _pass.text, context);
                          } else {
                            showErrorSnackbarRed(
                                context, "FILL ALL THE FIELDS");
                          }
                        },
                        icon: Icon(Icons.login),
                        label: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "Don't have account?",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return SignupPage();
                        }));
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    //showLoaderDialog(context);
    showErrorSnackbar(context, "connecting to server....");
    final sh = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DatabaseEvent event = await _login.once();
      dynamic data = event.snapshot.value;
      print(data);
      uid = userCredential.user!.uid;
      sh.setString("uid", uid!);
      uidd = uid;
      if (data[uid]["Type"] == "Worker") {
        print("worker");
        sh.setString("login", "Worker");
        uidd = uid;
        sh.setString("uid", uid!);

        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          return Worker(
            id: uid!,
          );
        }));
      } else if (data[uid]["Type"] == "User") {
        print("User");
        sh.setString("login", "User");
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          return Userhome();
        }));
      }

      print('Signed in with UID: $uid');
    } catch (e) {
      print('Sign in error: $e');
      Navigator.of(context).pop();
      showErrorSnackbar(context, e.toString());
    }
  }

  void showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: 7), child: Text("Connecting...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showErrorSnackbarRed(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3), // Adjust the duration as needed
    ),
  );
}
