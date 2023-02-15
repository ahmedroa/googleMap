import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';

class geolocator extends StatefulWidget {
  const geolocator({Key? key}) : super(key: key);

  @override
  State<geolocator> createState() => _geolocatorState();
}

class _geolocatorState extends State<geolocator> {
  @override
  Position? cl;
  LocationPermission? per;

  getPostion() async {
    late bool services;

    services = await Geolocator.isLocationServiceEnabled();
    print(services);

    if (services == false) {
      per = await Geolocator.checkPermission(); // افحص الصلاحيات

      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission(); // اطلب صلاحيات الموقع

        if (per == LocationPermission.always) {
          getLatAndLong();
        }
      }
    }
  }

  requestPermission() async {
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      // if (per == LocationPermission.always) {
      //   getLatAndLong();
      // }
    }
  }

  getLatAndLong() async {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                cl = await getLatAndLong();
                print(cl!.latitude);
                print(cl!.longitude);
              },
              child: Text('data'))
        ],
      ),
    );
  }
}
