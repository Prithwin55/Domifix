import 'dart:ffi';

import 'package:domifix/Screens/User/User.dart';
import 'package:domifix/Screens/User/homeUser.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class reviews extends StatefulWidget {
  String workerid;
  String type;
  String username;
  String price;
  reviews(
      {required this.workerid,
      required this.type,
      required this.username,
      required this.price});

  @override
  State<reviews> createState() => _reviewsState();
}

final _cntrl = TextEditingController();
double? rating = 3;
String? review;

class _reviewsState extends State<reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 244, 243),
      appBar: AppBar(
        title: Text("Reviews and Ratings"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Ratings:",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 189, 154, 154),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _ratingbar(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Share Your Experience:",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 189, 154, 154),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    maxLines: 10,
                    controller: _cntrl,
                    decoration: InputDecoration(
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(),
                        hintText: "Comments........",
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      await updateWorker(
                          rating!, _cntrl.text, widget.username, widget.price);
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (ctx) {
                        return Userhome();
                      }));
                      // Navigator.of(context).pop();
                    },
                    child: Text("SUBMIT"))),
          )
        ],
      ),
    );
  }

  Future<void> updateWorker(
      double rating, String review, String name, String price) async {
    final _workerdb = FirebaseDatabase.instance
        .ref()
        .child(widget.type)
        .child(widget.workerid);

    final _TotalSavings = FirebaseDatabase.instance
        .ref()
        .child("WorkerSavings")
        .child(widget.workerid);

    final _reviewdb =
        FirebaseDatabase.instance.ref().child("Review").child(widget.workerid);
    DatabaseEvent event = await _workerdb.once();
    dynamic data = event.snapshot.value;

    String time = DateTime.now().millisecondsSinceEpoch.toString();

    String r = data["Rating"];
    double ra = double.parse(r);

    double numrate = (ra + rating) / 2;

    Map<String, String> values = {
      "Rating": numrate.toString(),
    };
    final date = DateTime.now();
    String d = date.day.toString() +
        '/' +
        date.month.toString() +
        '/' +
        date.year.toString();
    Map<String, String> val = {
      "Username": name,
      "Rating": rating.toString(),
      "Review": review,
      "Price": price,
      "Date": d
    };
    _workerdb.update(values);
    _reviewdb.child(time).update(val);

    DatabaseEvent cprice = await _TotalSavings.once();
    dynamic dataprice = cprice.snapshot.value;

    String p = dataprice["Earnings"] != null ? dataprice["Earnings"] : "0";
    double pp = double.parse(p);
    double newprice = pp + double.parse(price);
    Map<String, String> valp = {"Earnings": newprice.toString()};
    _TotalSavings.update(valp);
  }
}

Widget _ratingbar() {
  return RatingBar.builder(
    initialRating: 3,
    itemSize: 50,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rat) {
      print(rat);
      rating = rat;
    },
  );
}
