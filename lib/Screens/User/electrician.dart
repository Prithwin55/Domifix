import 'dart:ffi';
import 'dart:io';

import 'package:domifix/Screens/User/displayProfile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic data;
File? selectedImage;
String? type;
final store = FirebaseStorage.instance.ref().child("Worker images");

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
//String? id;

String? gpsfullname;

class electrician extends StatefulWidget {
  const electrician({super.key});

  @override
  State<electrician> createState() => _electricianState();
}

class _electricianState extends State<electrician> {
  final _workerdb = FirebaseDatabase.instance.ref().child(type!);
  bool gps = false;
  bool fin = false;
  List listofkeys = [];
  dynamic sorted = {};

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            gps = true;
          });
          showDialog(
            context: context,
            barrierDismissible:
                false, // Prevent dialog from closing on tap outside
            builder: (context) {
              return Stack(
                children: [
                  // Background dimming effect
                  Container(
                    color: Colors.black
                        .withOpacity(0.8), // Adjust opacity as needed
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // Centered content
                  Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ],
              );
            },
          );

          // Map<String, Marker> wmark = await workermarker();
          // Marker mymark = await mymarker();
          // List<Future<void>> futures = [];

          // print("object");
          // Navigator.of(context).pop();

          // FlutterMapMath m = FlutterMapMath();

          // double distance = m.distanceBetween(
          //     37.4219999, -122.0840575, 37.4220011, -122.0866519, "meters");
          // print(distance);
          //calculateDistance();
          dynamic sorted = await cal();
          print(sorted);
          listofkeys = sorted.keys.toList();
          print(listofkeys);
          Navigator.of(context).pop();
          setState(() {
            sorted;
            listofkeys;
          });
        },
        child: Icon(Icons.gps_fixed_sharp),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
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
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  query: _workerdb,
                  sort: (a, b) {
                    if (listofkeys != null) {
                      int indexA = listofkeys!.indexOf(a.key);
                      int indexB = listofkeys!.indexOf(b.key);
                      return indexA.compareTo(indexB);
                    }
                    return 0;
                  },
                  itemBuilder: (ctx, snapshot, animation, index) {
                    var edu = RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Hello'),
                          TextSpan(
                              text: 'World',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                    String id = snapshot.child("Id").value.toString();
                    String rr = snapshot.child("Rating").value.toString();
                    listofkeys.add(id);
                    double rating = double.parse(rr);
                    print("main " + id!);
                    _name = snapshot
                        .child("Fullname")
                        .value
                        .toString()
                        .toUpperCase();

                    List namesplit = _name.split(' ');
                    String newName = namesplit[0];
                    _image = snapshot.child("Image").value.toString();
                    _education = snapshot
                        .child("Education")
                        .value
                        .toString()
                        .toUpperCase();
                    _rate = snapshot.child("Rate").value.toString();
                    _skill =
                        snapshot.child("Skill").value.toString().toUpperCase();
                    if (!gps) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // Prevent dialog from closing on tap outside
                              builder: (context) {
                                return Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                  color: Colors.white,
                                  size: 100,
                                ));
                              },
                            );
                            await Fetchdatabaseworker(id, type!);
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return displayProfile(
                                id: id,
                              );
                            }));
                          },
                          child: Container(
                              width: double.infinity,
                              height: 150,
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
                                                backgroundImage:
                                                    NetworkImage(_image!),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            newName,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "EDUCATION: " + _education!,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Text("     " + _education!),
                                          // SizedBox(
                                          //   height: 4,
                                          // ),
                                          Text(
                                            "RATE: " + _rate!,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "SKILL: " + _skill!,
                                            style: TextStyle(fontSize: 15),
                                          ),

                                          Expanded(
                                              child:
                                                  _ratingbaar(context, rating))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Icon(Icons.arrow_right_alt),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<dynamic>(
                          future: fetchDb(index),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              dynamic dat = snapshot.data;
                              String gname = dat["Fullname"];
                              List gnamesplit = gname.split(' ');
                              String gnewName = gnamesplit[0].toUpperCase();

                              String gid = dat["Id"];
                              String grr = dat["Rating"].toString();

                              double grating = double.parse(grr);
                              print("main " + id!);

                              String _image = dat["Image"].toString();
                              String _education =
                                  dat["Education"].toString().toUpperCase();
                              String _rate = dat["Rate"].toString();
                              String _skill =
                                  dat["Skill"].toString().toUpperCase();

                              return GestureDetector(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // Prevent dialog from closing on tap outside
                                    builder: (context) {
                                      return Center(
                                        child: LoadingAnimationWidget
                                            .staggeredDotsWave(
                                          color: Colors.white,
                                          size:
                                              100, // Adjust the size as needed (smaller)
                                        ),
                                      );
                                    },
                                  );

                                  await Fetchdatabaseworker(gid, type!);
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return displayProfile(
                                      id: id,
                                    );
                                  }));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 238, 223, 235),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 50,
                                                    backgroundImage:
                                                        NetworkImage(_image!),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                gnewName,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "EDUCATION: " + _education!,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "RATE: " + _rate!,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "SKILL: " + _skill!,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Expanded(
                                                  child: _ratingbaar(
                                                      context, grating))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                child:
                                                    Icon(Icons.arrow_right_alt),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> getloc() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        return await Geolocator.getCurrentPosition();
      }
    } catch (e) {
      showErrorSnackbar(context, "Permission is required");
    }
  }

  Future<dynamic> workermarker() async {
    final _workerdb = FirebaseDatabase.instance.ref().child(type!);
    DatabaseEvent event = await _workerdb.once();
    data = event.snapshot.value;
    //print(data);
    // print(data["9qqlEhov6wgrjsoSCQYCQcbwQYz1"]);
    List<Future<void>> futures = [];

    Map<String, Marker> workerMarker = {};
    await data.forEach((key, value) async {
      print(value["Address"]);
      //print(getcordinates(value["Address"]));

      dynamic m = await getcordinates(value["Address"]);
      if (m != null) {
        workerMarker.addAll({value["Id"]: m});
      } else {
        showErrorSnackbar(context, "ERROR OCCURED WHILE FETCHING LOCATION");
      }
    });

    return workerMarker;
  }

  Future<Marker> mymarker() async {
    String latitude;
    String longitude;
    Marker? _mylocmarker;
    await getloc().then((value) async {
      latitude = value.latitude.toString();
      longitude = value.latitude.toString();
      print(latitude + " " + longitude);
      _mylocmarker = Marker(
        markerId: MarkerId("222"),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: InfoWindow(title: "Myloc"),
      );
    });
    return _mylocmarker!;
  }

  Future<void> calculateDistance() async {
    final _workerdb = FirebaseDatabase.instance.ref().child(type!);
    DatabaseEvent event = await _workerdb.once();
    data = event.snapshot.value;
    double? latitude;
    double? longitude;
    await getloc().then((value) async {
      latitude = value.latitude;
      longitude = value.longitude;
      print("Latitide${latitude}  Longitude ${longitude}");
    });

    Map<String, double> distance = {};
    await data.forEach((key, value) async {
      dynamic m = await getcordinates(value["Address"]);

      FlutterMapMath map = FlutterMapMath();
      double dist =
          map.distanceBetween(latitude!, longitude!, m[0], m[1], "kilometers");
      print(dist);

      distance.addAll({value["Id"]: dist});
    });
    print(distance);
  }

  Future<Map<String, double>> cal() async {
    final _workerdb = FirebaseDatabase.instance.ref().child(type!);
    DatabaseEvent event = await _workerdb.once();
    data = event.snapshot.value;
    double? latitude;
    double? longitude;
    await getloc().then((value) {
      latitude = value.latitude;
      longitude = value.longitude;
      print("Latitide${latitude}  Longitude ${longitude}");
    });
    Map<String, double> distance = {};
    try {
      for (var entry in data.entries) {
        dynamic m = await getcordinates(entry.value["Address"]);
        if (m != null) {
          FlutterMapMath map = FlutterMapMath();
          double dist = map.distanceBetween(
              latitude!, longitude!, m[0], m[1], "kilometers");
          print(dist);
          distance[entry.value["Id"]] = dist;
        }
      }
    } catch (e) {}
    print(distance);

    Map<String, double> sortedMap = sortMapAscending(distance);
    print(sortedMap);

    return sortedMap;
  }

  Future<dynamic> fetchDb(int index) async {
    String cur_id = listofkeys![index];
    print(cur_id);
    var db = _workerdb.child(cur_id);
    DatabaseEvent event = await db.once();
    dynamic dat = event.snapshot.value;
    print(dat["Fullname"]);

    return dat;
  }
}

Future<void> assign(String t) async {
  // "Electrician"
  type = t;
}

Widget _ratingbar() {
  return RatingBar.builder(
    initialRating: 3,
    itemSize: 27,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}

Widget _ratingbaar(BuildContext context, double rating) {
  return RatingBarIndicator(
    rating: rating,
    itemBuilder: (context, index) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: 27.0,
    direction: Axis.horizontal,
  );
}

Future<dynamic> getcordinates(String user) async {
  String usrdupli = user;
  GeoCode geoCode = GeoCode();
  Coordinates usr = await geoCode.forwardGeocoding(address: user);
  // Coordinates work = await geoCode.forwardGeocoding(address: worker);

  print("lat: ${usr.latitude}" + " long: ${usr.longitude}");
  //print("Worker: ${work.longitude}");
  if (usr.latitude != null && usr.longitude != null) {
    // Marker _marker = Marker(
    //   markerId: MarkerId("1"),
    //   position: LatLng(usr.latitude!, usr.longitude!),
    //   infoWindow: InfoWindow(title: "User"),
    // );

    // Marker(
    //   markerId: MarkerId("2"),
    //   position: LatLng(work.latitude!, work.longitude!),
    //   infoWindow: InfoWindow(title: "Worker"),
    // )

    return [usr.latitude, usr.longitude];
  } else {
    return getcordinates(usrdupli);
  }
}

Map<String, double> sortMapAscending(Map<String, double> inputMap) {
  // Convert the map into a list of map entries
  List<MapEntry<String, double>> entries = inputMap.entries.toList();

  // Sort the list based on the double values in ascending order
  entries.sort((a, b) => a.value.compareTo(b.value));

  // Convert the sorted list back to a map
  Map<String, double> sortedMap = Map.fromEntries(entries);

  return sortedMap;
}
