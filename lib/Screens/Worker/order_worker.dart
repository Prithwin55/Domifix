import 'package:domifix/Screens/Worker/map.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:domifix/Screens/Splash.dart';

String? userid;

var _ordersdb =
    FirebaseDatabase.instance.ref().child("Worker_orders").child(uidd!);
bool ispressed = true;

class Orderworker extends StatefulWidget {
  const Orderworker({super.key});

  @override
  State<Orderworker> createState() => _OrderworkerState();
}

class _OrderworkerState extends State<Orderworker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    //await Future.delayed(Duration(seconds: 3));
    final SharedPreferences sh = await SharedPreferences.getInstance();
    userid = sh.getString("uid");
    print(userid);
    _ordersdb =
        FirebaseDatabase.instance.ref().child("Worker_orders").child(userid!);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: _ordersdb,
                itemBuilder: (ctx, snapshot, animation, index) {
                  String id = snapshot.child("Order_id").value.toString();
                  String date = snapshot.child("Date").value.toString();
                  String start_time =
                      snapshot.child("Starting_time").value.toString();
                  String end_time =
                      snapshot.child("Ending_time").value.toString();
                  String rate = snapshot.child("Rate").value.toString();

                  String ord_user_id =
                      snapshot.child("user_id").value.toString();
                  String ord_Worker_id =
                      snapshot.child("Worker_id").value.toString();
                  String status = snapshot.child("Status").value.toString();
                  String user_name =
                      snapshot.child("Username").value.toString();
                  String Uimage = snapshot.child("User_image").value.toString();
                  String useraddr =
                      snapshot.child("User_address").value.toString();
                  String workeraddr =
                      snapshot.child("Worker_address").value.toString();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 238, 223, 235),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 50,
                                          backgroundImage: NetworkImage(Uimage),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user_name.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "From " + start_time + " to " + end_time,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Text("     " + _education!),
                                    // SizedBox(
                                    //   height: 4,
                                    // ),
                                    Text(
                                      "Rate: " + rate + " ₹",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Date: " + date,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Order id: " + id,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    Stack(
                                      children: [
                                        Visibility(
                                          visible:
                                              status == "no" ? true : false,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await DeleteOrder(
                                                      id,
                                                      ord_user_id,
                                                      ord_Worker_id);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 50, 35),
                                                ),
                                                child: Text("Reject"),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _ordersdb.child(id).update(
                                                        {"Status": "yes"});
                                                    final _ordersuserdb =
                                                        FirebaseDatabase
                                                            .instance
                                                            .ref()
                                                            .child(
                                                                "User_orders")
                                                            .child(ord_user_id)
                                                            .child(id);
                                                    _ordersuserdb.update(
                                                        {"Status": "yes"});
                                                  },
                                                  child: Text("Accept"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Visibility(
                                              visible:
                                                  status == "no" ? false : true,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      });
                                                  dynamic marker =
                                                      await getcordinates(
                                                          useraddr, workeraddr);
                                                  Navigator.of(context).pop();
                                                  if (marker != null) {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (ctx) {
                                                      return map(
                                                        marker: marker,
                                                      );
                                                    }));
                                                  } else {
                                                    showErrorSnackbar(context,
                                                        "Network Error Occurred....Try again");
                                                  }
                                                },
                                                child: Text('View Location'),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(20.0),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.end,
                            //       children: [
                            //         Container(
                            //           child: Icon(Icons.arrow_right_alt),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> getcordinates(String user, String worker) async {
  GeoCode geoCode = GeoCode();
  Coordinates usr = await geoCode.forwardGeocoding(address: user);
  // Coordinates work = await geoCode.forwardGeocoding(address: worker);

  print("User: ${usr.latitude}");
  //print("Worker: ${work.longitude}");
  if (usr.latitude != null && usr.longitude != null) {
    List<Marker> _marker = [
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(usr.latitude!, usr.longitude!),
        infoWindow: InfoWindow(title: "User"),
      ),
      // Marker(
      //   markerId: MarkerId("2"),
      //   position: LatLng(work.latitude!, work.longitude!),
      //   infoWindow: InfoWindow(title: "Worker"),
      // )
    ];
    return _marker;
  } else {
    return null;
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

Future<void> DeleteOrder(String ord, String usr, String wor) async {
  final SharedPreferences sh = await SharedPreferences.getInstance();
  final usrid = sh.getString("uid");
  final _user = FirebaseDatabase.instance
      .ref()
      .child("User_orders")
      .child(usr)
      .child(ord!);
  final _worker = FirebaseDatabase.instance
      .ref()
      .child("Worker_orders")
      .child(wor)
      .child(ord!);
  print("USER:" + usr + " Worker:" + wor + " id:" + ord);
  _worker.remove();
  _user.remove();
}
