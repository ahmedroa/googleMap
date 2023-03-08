import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappp/constants/constants.dart';
import 'package:mappp/widgets/request.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool mapToggle = false;

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
    setState(() {
      mapToggle = true;
    });
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
  bool isloading = true;

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

  GlobalKey<ScaffoldState> Scaffoldkey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: Scaffoldkey,
          drawer: NavBar(),
          body: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Container(
                  // height: 500,
                  child: mapToggle
                      ? Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            GoogleMap(
                              onTap: (latlng) {
                                myMarker
                                    .remove(Marker(markerId: MarkerId('1')));
                                myMarker.add(Marker(
                                  markerId: MarkerId('1'),
                                  position: latlng,
                                ));
                                setState(() {});
                              },
                              markers: myMarker,
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (controller) async {
                                gmc = controller;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: request(),
                            ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator())),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () async {
                            Scaffoldkey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Icons.list,
                            color: kBlueColor,
                          )),
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () async {},
                          icon: Icon(
                            Icons.notifications,
                            color: kBlueColor,
                          )),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          )
          // markers: myMarkers,
          ),
    );
  }
}

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text('Ahmed khalid'),
            accountName: Text('+249111472374'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://pbs.twimg.com/profile_images/1534269732773408769/E_cXOiuD_400x400.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: kBlueColor,
            ),
          ),
        ],
      ),
    );
  }
}
