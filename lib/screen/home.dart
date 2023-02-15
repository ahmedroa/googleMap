import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Position? cl;
  var lat;
  var lang;
  GoogleMapController? gmc;
  LocationPermission? per;
  late CameraPosition _kGooglePlex;
  Set<Marker> myMarker = {
    Marker(
      draggable: true,
      markerId: MarkerId(
        '1',
      ),
      position: LatLng(15.512403, 32.595981),
    )
  };

  getPer() async {
    late bool services;

    services = await Geolocator.isLocationServiceEnabled();
    print(services);

    if (services == false) {
      per = await Geolocator.checkPermission(); // افحص الصلاحيات

      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission(); // اطلب صلاحيات الموقع

      }
      getLatAndLong();
      {
        getLatAndLong();
      }
    }
  }

  getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    lang = cl!.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lang),
      zoom: 14.4746,
    );
    setState(() {});
  }

  requestPermission() async {
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      // if (per == LocationPermission.always) {
      //   getLatAndLong();
      // }
    }
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(15.512403, 32.595981),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );
  @override
  void initState() {
    getPer();
    getLatAndLong();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    LatLng latLng = LatLng(15.544421, 32.590037);
                    gmc!.animateCamera(CameraUpdate.newLatLng(latLng));
                  },
                  icon: Icon(Icons.adb_sharp)),
              IconButton(
                  onPressed: () async {
                    var latlong =
                        await gmc!.getLatLng(ScreenCoordinate(x: 200, y: 200));
                    print(latlong);
                  },
                  icon: Icon(Icons.adb_sharp)),
            ],
          )
        ],
      ),
      body: Container(
        child: _kGooglePlex == null
            ? CircularProgressIndicator()
            : GoogleMap(
                onTap: (latlng) {
                  myMarker.remove(Marker(markerId: MarkerId('1')));
                  myMarker
                      .add(Marker(markerId: MarkerId('1'), position: latlng));
                  setState(() {});
                },
                markers: myMarker,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (controller) {
                  gmc = controller;
                },
              ),
      ),
      // markers: myMarkers,
    );
  }
}
