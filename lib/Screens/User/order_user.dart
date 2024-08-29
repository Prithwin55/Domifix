import 'package:domifix/Screens/User/gpay.dart';
import 'package:domifix/Screens/User/payment.dart';
import 'package:domifix/Screens/User/reviews.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:domifix/Screens/Splash.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

String? ord, usr, wor, ty, username, price;

String? userid;
var _ordersdb =
    FirebaseDatabase.instance.ref().child("User_orders").child(uidd!);

class Orderuser extends StatefulWidget {
  const Orderuser({super.key});

  @override
  State<Orderuser> createState() => _OrderuserState();
}

class _OrderuserState extends State<Orderuser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPreferences();
  }

  Future<void> loadSharedPreferences() async {
    final SharedPreferences sh = await SharedPreferences.getInstance();
    userid = sh.getString("uid");
    print(userid);
    _ordersdb =
        FirebaseDatabase.instance.ref().child("User_orders").child(userid!);
  }

  @override
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
                  String type = snapshot.child("Type").value.toString();

                  String ord_user_id =
                      snapshot.child("user_id").value.toString();
                  String ord_Worker_id =
                      snapshot.child("Worker_id").value.toString();
                  String status = snapshot.child("Status").value.toString();
                  String worker_name =
                      snapshot.child("Workername").value.toString();
                  String Wimage =
                      snapshot.child("Worker_image").value.toString();
                  String upi = snapshot.child("Upi").value.toString();
                  String name = snapshot.child("Username").value.toString();

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
                                          backgroundImage: NetworkImage(Wimage),
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
                                      worker_name.toUpperCase(),
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
                                              Text(
                                                "Waiting for Reply..",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              )
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
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //     MaterialPageRoute(
                                                  //         builder: (ctx) {
                                                  //   return Payment(
                                                  //     upi: upi,
                                                  //     rate: rate,
                                                  //     name: worker_name,
                                                  //   );
                                                  // }));
                                                  // Navigator.of(context).push(
                                                  //     MaterialPageRoute(
                                                  //         builder: (ctx) {
                                                  //   return Gpay(
                                                  //     title: "Payment",
                                                  //     amount: rate,
                                                  //   );
                                                  // }));
                                                  ord = id;
                                                  usr = ord_user_id;
                                                  wor = ord_Worker_id;
                                                  ty = type!;
                                                  price = rate;
                                                  username = name;
                                                  initiate(rate, upi);
                                                },
                                                child: Text('Pay'),
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

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
    // print("Success");
    DeleteOrder(ord!, usr!, wor!);
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return reviews(
        workerid: wor!,
        type: ty!,
        username: username!,
        price: price!,
      );
    }));
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        print(message);
        // if (message.startsWith('Payment')) {
        //   print("in iff");
        // } else {
        //   print("wlse");
        // }
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void initiate(String rate, String upi) {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': upi,
      'amount': double.parse(rate).toInt() * 100,
      'name': 'Domifix',
      'description': 'Service Charge',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }
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
