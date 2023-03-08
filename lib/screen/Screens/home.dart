import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappp/constants/constants.dart';
import 'package:mappp/helper/location_helper.dart';
import 'package:mappp/screen/home.dart';
import 'package:mappp/widgets/request.dart';

class homeS extends StatefulWidget {
  const homeS({Key? key}) : super(key: key);

  @override
  State<homeS> createState() => _homeSState();
}

class _homeSState extends State<homeS> {
  // List<PlaceSuggestion> places = [];
  // FloatingSearchBarController controller = FloatingSearchBarController();
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  // these variables for getPlaceLocation
  Set<Marker> markers = Set();
  // late PlaceSuggestion placeSuggestion;
  // late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 13,
    );
  }

  // these variables for getDirections
  // PlaceDirections? placeDirections;
  var progressIndicator = false;
  late List<LatLng> polylinePoints;
  var isSearchedPlaceMarkerClicked = false;
  var isTimeAndDistanceVisible = false;
  late String time;
  late String distance;

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  late Position _currentPosition;
  String _currentAddress = '';
  String _startAddress = '';
  final startAddressController = TextEditingController();

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        gmc!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  bool mapToggle = false;

  Position? cl;
  static var lat;
  static var lang;
  GoogleMapController? gmc;
  LocationPermission? per;
  late CameraPosition _kGooglePlex;

  Set<Marker> myMarker = {
    Marker(
      draggable: true,
      markerId: MarkerId(
        '1',
      ),
      position: LatLng(position!.latitude, position!.longitude),
    )
  };

  getPer() async {
    late bool services;
    services = await Geolocator.isLocationServiceEnabled();
    print(services);
    if (services == true) {
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
    print(lat);
    print('============================');
    print(lang);
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

  // static const CameraPosition _kLake = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: LatLng(15.512403, 32.595981),
  //   tilt: 59.440717697143555,
  //   zoom: 19.151926040649414,
  // );

  @override
  void initState() {
    getPer();
    getLatAndLong();
    getMyCurrentLocation();
    super.initState();
  }

  GlobalKey<ScaffoldState> Scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
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
                                // myLocationEnabled: true,
                                // zoomControlsEnabled: false,
                                onTap: (latlng) {
                                  myMarker
                                      .remove(Marker(markerId: MarkerId('1')));
                                  myMarker.add(Marker(
                                    markerId: MarkerId('1'),
                                    position: LatLng(
                                        latlng.latitude, latlng.longitude),
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
                                child: Container(
                                  color: Colors.white,
                                  // height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.near_me,
                                          color: kBlueColor,
                                        ),
                                        Text(
                                          'Destion Please... ?',
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator())),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () async {
                                  // getLatAndLong();
                                  // Scaffoldkey.currentState!.openDrawer();
                                  // List<Placemark> placemarks =
                                  //     await placemarkFromCoordinates(
                                  //         15.512403, 32.595981);
                                  // print(placemarks[0].administrativeArea);
                                  // print(placemarks[0].name);
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
                                onPressed: () async {
                                  LatLng latLng = LatLng(15.544421, 32.590037);
                                  gmc!.animateCamera(
                                      CameraUpdate.newLatLng(latLng));
                                },
                                icon: Icon(
                                  Icons.notifications,
                                  color: kBlueColor,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        // height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.near_me,
                                color: kBlueColor,
                              ),
                              Text(
                                'Destion Please... ?',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            )));
    // markers: myMarkers,);
  }
}
