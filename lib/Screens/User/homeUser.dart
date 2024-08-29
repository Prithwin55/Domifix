import 'package:domifix/Screens/User/electrician.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final store = FirebaseStorage.instance.ref().child("User images");

class userHome extends StatefulWidget {
  const userHome({super.key});

  @override
  State<userHome> createState() => _userHomeState();
}

class _userHomeState extends State<userHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 238, 225, 246),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                await assign("Electrician");
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return electrician();
                }));
              },
              child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/User%20images%2FElectrician(1).png?alt=media&token=5ec37bfa-1346-4dad-b84a-9193f6214cf3&_gl=1*1onkreh*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njk5ODAwOS43LjEuMTY5Njk5OTU1OS4xNS4wLjA."),
                            radius: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "ELECTRICIAN",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                await assign("Plumber");
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return electrician();
                }));
              },
              child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/User%20images%2FPlumber.png?alt=media&token=7446e560-6d50-4ced-8695-1a5e0e635d1e&_gl=1*1fv1kfs*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njk5ODAwOS43LjEuMTY5Njk5ODUxNi41My4wLjA."),
                            radius: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "PLUMBER",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                await assign("Gardener");
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return electrician();
                }));
              },
              child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/User%20images%2FGardener.png?alt=media&token=5a77a5bb-1d32-42d7-9481-48f0879e237c&_gl=1*1kj4d0m*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njk5ODAwOS43LjEuMTY5Njk5OTc2Mi40OS4wLjA."),
                            radius: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "GARDENER",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                await assign("Home Nurse");
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return electrician();
                }));
              },
              child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/User%20images%2Fhome%20nurse.png?alt=media&token=4666d989-70f7-44d8-b829-1d027e47cb98&_gl=1*p96knd*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njk5ODAwOS43LjEuMTY5NzAwMDAxOS41MC4wLjA."),
                            radius: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "HOME NURSE",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    });
                await assign("Interior Designer");
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return electrician();
                }));
              },
              child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/domifix-75968.appspot.com/o/User%20images%2Finterior%20designer.png?alt=media&token=81cf90a7-9378-4cc1-b59c-ab7fe98c44f0&_gl=1*11hpxjq*_ga*Nzc2MjE2MzQ0LjE2OTY1NzMxNDA.*_ga_CW55HF8NVT*MTY5Njk5ODAwOS43LjEuMTY5NzAwMDIzNi40Ny4wLjA."),
                            radius: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "INTERIOR DESIGNER",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
