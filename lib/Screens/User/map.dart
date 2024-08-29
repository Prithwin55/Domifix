import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final initial = const CameraPosition(
    target: LatLng(12.481039848709985, 75.20997483604025), zoom: 14.0);
Completer<GoogleMapController> _controller = Completer();
List<Marker> _marker = [];

class Usermap extends StatefulWidget {
  const Usermap({super.key});

  @override
  State<Usermap> createState() => _UsermapState();
}

class _UsermapState extends State<Usermap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initial,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
