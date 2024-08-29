import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatefulWidget {
  List<Marker> marker;
  map({super.key, required this.marker});

  @override
  State<map> createState() => _mapState();
}

final initial = const CameraPosition(
    target: LatLng(12.481039848709985, 75.20997483604025), zoom: 14.0);

class _mapState extends State<map> {
  double distance = 0.0;

  Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Color.fromARGB(255, 62, 207, 240),
        points: polylineCoordinates,
        width: 8);
    polylines[id] = polyline;

    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    print(totalDistance.toString() + "KM");

    setState(() {
      distance = totalDistance;
    });

    setState(() {});
  }

  _getPolyline() async {
    try {
      polylines.clear();
      polylineCoordinates.clear();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'API_KEY',
        PointLatLng(widget.marker[1].position.latitude,
            widget.marker[1].position.longitude),
        PointLatLng(widget.marker[0].position.latitude,
            widget.marker[0].position.longitude),
        travelMode: TravelMode.driving,
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    } catch (e) {
      return Future.error("Location is disabled");
      //showErrorSnackbar(context, "No Routes are available....");
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          polylines: Set<Polyline>.of(polylines.values),
          initialCameraPosition: initial,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          markers: Set<Marker>.of(widget.marker),
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
        ),
        Positioned(
            top: 50,
            left: 10,
            child: Container(
                child: Card(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "Total Distance: " + distance.toStringAsFixed(2) + " KM",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            )))
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic val;
            showDialog(
                context: context,
                builder: (context) {
                  return Center(child: CircularProgressIndicator());
                });
            await getlocation().then((value) async {
              val = value;
              if (value != null) {
                print(value.latitude.toString() +
                    "," +
                    value.latitude.toString());

                setState(() {
                  widget.marker.add(Marker(
                    position: LatLng(value.latitude, value.longitude),
                    markerId: MarkerId("22"),
                    infoWindow: InfoWindow(title: "Worker"),
                  ));
                });
                final mapcntrl = await _controller.future;
                mapcntrl.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(value.latitude, value.longitude),
                        zoom: 14)));
              }
            });
            if (val != null) {
              await _getPolyline();
            }

            Navigator.of(context).pop();
          },
          child: Icon(Icons.gps_fixed)),
    );
  }

  Future<dynamic> getlocation() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        return await Geolocator.getCurrentPosition();
      }
    } catch (e) {
      showErrorSnackbar(context, "Permission is required");
    }
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

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
