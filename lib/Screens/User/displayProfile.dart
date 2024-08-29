import 'package:domifix/Screens/User/homeUser.dart';
import 'package:domifix/Screens/User/reviews.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocode/geocode.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic _data;
String? typ;
dynamic _datauser;
String? userid;
String _name = "";
String _img_user = "";
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
String? _rate = "";
String? _loc = "";
String? uidd1;
String? _lat;
String? _log;
String? day;
String? month;
String? year;
String? date;
String? startingTime;
String? endingTime;
String? _rating;

String? useraddr;
String? _upi;
String? workeraddr;
String? user_name;
int? shours = 0;
int? smint = 0;
int? ehours = 0;
int? emint = 0;

int? totalhour;
int? totalmint;
bool status = false;

double? total_rate;

final rev = null;

class displayProfile extends StatefulWidget {
  String id;
  displayProfile({required this.id});

  @override
  State<displayProfile> createState() => _displayProfileState();
}

class _displayProfileState extends State<displayProfile> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 35),
        child: FloatingActionButton(
          onPressed: () {
            Review();
          },
          child: Icon(Icons.reviews),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                // color: Colors.orange,
                child: Center(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/prof.jpeg",
                        ),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "RATE: " + _rate! + " ₹",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "EXPERIENCE: " + _exp!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "MOBILE NO: " + _phone,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.email),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Email: " + _email,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "Location: " + _loc!,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.work),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "Profession: " + _proff!,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Rating : -",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            _ratingbaar(context, double.parse(_rating!))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "ABOUT:-",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                _about!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      //color: Colors.green,
                      ),
                  width: double.infinity,
                  height: 35,
                  // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showbottomsheet(context);
                    },
                    icon: Icon(Icons.trending_up),
                    label: Text(
                      "BOOK NOW",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 1, 239, 85),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 125.0,
            // (background container size) - (circle height / 2)
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 228, 228, 228),
                  image: DecorationImage(image: NetworkImage(_image!))),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showbottomsheet(BuildContext context) async {
    showModalBottomSheet(
        backgroundColor: Colors.green,
        elevation: 5,
        context: context,
        builder: (ctx1) {
          return StatefulBuilder(builder: (builder, state) {
            Future<void> booknow(BuildContext ctx) async {
              final SharedPreferences sh =
                  await SharedPreferences.getInstance();
              String time = DateTime.now().millisecondsSinceEpoch.toString();
              uidd1 = sh.getString("uid");
              final _orderworker_db = FirebaseDatabase.instance
                  .ref()
                  .child("Worker_orders")
                  .child(userid!)
                  .child(time);
              final _orderuser_db = FirebaseDatabase.instance
                  .ref()
                  .child("User_orders")
                  .child(uidd1!)
                  .child(time);

              if (startingTime != null &&
                  endingTime != null &&
                  date != null &&
                  total_rate != null) {
                Map<String, String> ord = {
                  "Order_id": time,
                  "user_id": uidd1!,
                  "Worker_id": userid!,
                  "Date": date!,
                  "Starting_time": startingTime!,
                  "Ending_time": endingTime!,
                  "Rate": total_rate.toString(),
                  "Status": "no",
                  "Username": user_name!,
                  "Workername": _name,
                  "Worker_image": _image!,
                  "User_image": _img_user,
                  "Worker_address": workeraddr!,
                  "User_address": useraddr!,
                  "Upi": _upi.toString(),
                  "Type": typ!
                };
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
                await _orderuser_db.set(ord);
                await _orderworker_db.set(ord);
                Navigator.of(context).pop();
                startingTime = null;
                endingTime = null;
                total_rate = null;
                date = null;
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                showErrorSnackbar(context, "FILL ALL THE FIELDS");
                Navigator.of(ctx).pop();
              }
            }

            Future<void> datepicker(BuildContext context) async {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000))
                  .then((value) {
                day = value?.day.toString();
                month = value?.month.toString();
                year = value?.year.toString();
                if (day != null && year != null && month != null) {
                  state(() {
                    date = day! + "/" + month! + "/" + year!;
                    print(date);
                  });
                }
              });
            }

            Future<void> timepicker(BuildContext context, int val) async {
              showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 12, minute: 00))
                  .then((value) {
                if (value != null && val == 1) {
                  print(value.format(context));
                  startingTime = value.format(context);
                  shours = value.hour;
                  smint = value.minute;
                  print(shours);
                  print(smint);
                  state(
                    () {},
                  );
                }
                if (value != null && val == 2) {
                  print(value.format(context));
                  endingTime = value.format(context);
                  ehours = value.hour;
                  emint = value.minute;
                  print(ehours);
                  print(emint);
                  state(
                    () {},
                  );
                }
              });
            }

            return Container(
              // width: double.infinity,
              padding: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    "BOOKING DETAILS",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "DATE:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 60,
                        width: 200,
                        child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      datepicker(context);
                                      state(() {
                                        date;
                                      });
                                    },
                                    icon: Icon(Icons.date_range)),
                                prefixIconColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                hintText:
                                    date == null ? "  Select a date" : date,
                                filled: true,
                                fillColor: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "STARTING TIME:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 20,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "ENDING TIME:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          width: 200,
                          child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        timepicker(context, 1);
                                      },
                                      icon: Icon(Icons.timer_outlined)),
                                  prefixIconColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  hintText: startingTime == null
                                      ? "  Select a time"
                                      : startingTime,
                                  filled: true,
                                  fillColor: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          width: 200,
                          child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        timepicker(context, 2);
                                      },
                                      icon: Icon(Icons.timer_outlined)),
                                  prefixIconColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  hintText: endingTime == null
                                      ? "  Select a time"
                                      : endingTime,
                                  filled: true,
                                  fillColor: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Rate:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          width: 200,
                          child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        totalhour = (ehours! - shours!).abs();
                                        totalmint = (emint! - smint!).abs();
                                        int rate = int.parse(_rate!);
                                        double totalrate = (totalhour! * rate) +
                                            ((totalmint! / 60) * rate);
                                        print(totalrate);
                                        total_rate = totalrate;
                                        state(() {});
                                      },
                                      icon: Icon(Icons.replay_outlined)),
                                  prefixIconColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  hintText: total_rate == null
                                      ? "  Rate"
                                      : total_rate.toString(),
                                  filled: true,
                                  fillColor: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                booknow(context);
                              },
                              icon: Icon(Icons.calculate),
                              label: Text("BOOK NOW"))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<void> Review() async {
    final _rev = FirebaseDatabase.instance.ref().child('Review').child(userid!);
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 225, 216),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Reviews And Ratings",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _rev.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData &&
                          snapshot.data!.snapshot.value != null) {
                        // Reviews available
                        dynamic data = snapshot.data!.snapshot.value;
                        if (data is Map<dynamic, dynamic>) {
                          Map<dynamic, dynamic> reviewsMap = data;
                          List<Widget> reviewTiles = [];
                          reviewsMap.forEach((key, value) {
                            String review = value["Review"].toString();
                            String usr = value["Username"].toString();
                            String rating = value["Rating"].toString();
                            reviewTiles.add(
                              ListTile(
                                title: Text(
                                  usr,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                  ),
                                ),
                                trailing:
                                    _ratingbaar(context, double.parse(rating)),
                                subtitle: Text(
                                  review,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                leading: Icon(Icons.person_2_outlined),
                              ),
                            );
                          });
                          return ListView(
                            children: reviewTiles,
                          );
                        } else {
                          // Data is not in the expected format
                          return Center(
                            child: Text(
                              "Data Format Error",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      } else {
                        // No reviews available
                        return Center(
                          child: Text(
                            "NO REVIEWS AVAILABLE!!!",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> Fetchdatabaseworker(String id, String ty) async {
  typ = ty;
  final SharedPreferences sh = await SharedPreferences.getInstance();
  uidd1 = sh.getString("uid");
  userid = id;
  final store = FirebaseStorage.instance.ref().child("Worker images");
  final _workerdb = FirebaseDatabase.instance.ref().child(ty).child(id);
  final _userdb = FirebaseDatabase.instance.ref().child("User").child(uidd1!);
  DatabaseEvent event = await _workerdb.once();
  DatabaseEvent eventuser = await _userdb.once();
  _data = event.snapshot.value;
  _datauser = eventuser.snapshot.value;
  //print(data);
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
  user_name = _datauser["Fullname"];
  _img_user = _datauser["Image"];
  _exp = _data["Experience"];
  useraddr = _datauser["Address"];
  workeraddr = _data["Address"];
  _assigned = _data["Assigned"];
  _rate = _data["Rate"];
  _lat = _data["Latitude"];
  _log = _data["Longitude"];
  _loc = _data["Address"];
  _upi = _data["Upi"];
  _rating = _data["Rating"];
  // try {
  //   GeoCode geoCode = GeoCode();
  //   Address address = await geoCode.reverseGeocoding(
  //       latitude: double.parse(_lat!), longitude: double.parse(_log!));

  //   _loc = address.streetAddress.toString() +
  //       "," +
  //       address.city.toString() +
  //       "," +
  //       address.postal.toString() +
  //       "," +
  //       address.countryName.toString();
  // } catch (e) {
  //   print(e);
  // }
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
