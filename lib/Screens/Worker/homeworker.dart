import 'package:domifix/Screens/Splash.dart';
import 'package:domifix/Screens/User/displayProfile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:domifix/Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userid = " ";
var _reviewdb = FirebaseDatabase.instance.ref().child("Review").child(userid);
final _TotalSavings =
    FirebaseDatabase.instance.ref().child("WorkerSavings").child(userid);

final _worker = FirebaseDatabase.instance.ref().child("Worker").child(userid);

String savings = "Fetching..", nameuser = "Fetching..";

class homeWorker extends StatefulWidget {
  String id;
  homeWorker({required this.id});

  @override
  State<homeWorker> createState() => _homeWorkerState();
}

class _homeWorkerState extends State<homeWorker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3, top: 3),
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7, top: 10),
                      child: Text(
                        "HELLO , " + nameuser + "  !...",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 231, 226, 226)),
                      ),
                    ),
                    height: 250,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 55, 79, 166),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        )),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 30,
              right: 30,
              top: 50,
              child: Container(
                child: Center(
                    child: Text(
                  "TOTAL SAVINGS:  " + savings! + "  ₹",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 63, 45, 95),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "TRANSACTION HISTORY",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  Expanded(
                    child: FirebaseAnimatedList(
                        query: _reviewdb,
                        itemBuilder: (ctx, snapshot, animation, index) {
                          String rating =
                              snapshot.child("Rating").value.toString();
                          String user =
                              snapshot.child("Username").value.toString();
                          String price =
                              snapshot.child("Price").value.toString();
                          String date = snapshot.child("Date").value.toString();
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                ListTile(
                                  selected: true,
                                  tileColor: Colors.green,
                                  selectedTileColor: Colors.amber,
                                  title: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(user),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 205, 191, 86),
                                          fontSize: 17),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage("assets/images/rupee.jpg"),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      price + "  +",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 40,
                                  color: Colors.black,
                                  thickness: 2,
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255))),
        )
      ],
    );
  }

  Future<void> loadSharedPreferences() async {
    //await Future.delayed(Duration(seconds: 3));
    final SharedPreferences sh = await SharedPreferences.getInstance();
    userid = sh.getString("uid")!;
    print(userid);
    _reviewdb =
        await FirebaseDatabase.instance.ref().child("Review").child(userid);
    final _worker =
        FirebaseDatabase.instance.ref().child("Worker").child(userid);
    DatabaseEvent worker = await _worker.once();
    dynamic orgworker = worker.snapshot.value;
    nameuser = orgworker["Fullname"];

    final _TotalSavings =
        FirebaseDatabase.instance.ref().child("WorkerSavings").child(userid);
    DatabaseEvent cprice = await _TotalSavings.once();
    dynamic dataprice = cprice.snapshot.value;
    savings = dataprice["Earnings"];

    setState(() {});
  }
}
