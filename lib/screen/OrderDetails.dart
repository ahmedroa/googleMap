import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappp/constants/constants.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
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
                              height: 250,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'تأكيد الحجز',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '2,050',
                                            style: TextStyle(
                                              color: kBlueColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      line(),
                                      type(
                                        test1: 'كود الخصم',
                                        test2: 'أدخل كود الخصم',
                                      ),
                                      line(),
                                      type(
                                        test1: 'رقم الاتصال',
                                        test2: '***********',
                                      ),
                                      line(),
                                      type(
                                        test1: 'ملاحظات السائق',
                                        test2: 'هل لديك ملاحظات للسائق ؟',
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: defaultButton(
                                              text: 'يلا !',
                                              function: () {},
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
