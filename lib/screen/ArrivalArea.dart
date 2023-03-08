import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappp/constants/constants.dart';
import 'package:mappp/screen/OrderDetails.dart';

class ArrivalArea extends StatefulWidget {
  const ArrivalArea({Key? key}) : super(key: key);

  @override
  State<ArrivalArea> createState() => _ArrivalAreaState();
}

class _ArrivalAreaState extends State<ArrivalArea> {
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
          // drawer: NavBar(),

          body: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Container(
                  // height: 500,
                  child: _kGooglePlex == null
                      ? CircularProgressIndicator()
                      : Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            GoogleMap(
                              onTap: (latlng) {
                                myMarker
                                    .remove(Marker(markerId: MarkerId('1')));
                                myMarker.add(Marker(
                                    markerId: MarkerId('1'), position: latlng));
                                setState(() {});
                              },
                              markers: myMarker,
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (controller) {
                                gmc = controller;
                              },
                            ),
                            Container(
                              color: Colors.white,
                              height: 180,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        'حدد نقطة النهاية',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //     Navigator.push(context,
                                          //         MaterialPageRoute(builder: ((context) => DeliveryRequest())));
                                        },
                                        child: Container(
                                          decoration: (BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          )),
                                          height: 50,
                                          child: Row(children: [
                                            Icon(Icons.location_on_outlined),
                                            Text('ابحث عن مكان')
                                          ]),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: defaultButton(
                                              text: 'إرسال طلب',
                                              function: () {
                                                Get.to(OrderDetails());
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: defaultButton(
                                              text: 'مشوار مفتوح',
                                              function: () {
                                                Get.to(OrderDetails());
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                    onPressed: () async {},
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: 28,
                      color: kBlueColor,
                    )),
              ),
              Spacer(),
            ],
          )
          // markers: myMarkers,
          ),
    );
  }
}
