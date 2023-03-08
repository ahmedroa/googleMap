import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';

class geocoding extends StatefulWidget {
  const geocoding({Key? key}) : super(key: key);

  @override
  State<geocoding> createState() => _geocodingState();
}

class _geocodingState extends State<geocoding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(21.422889, 39.826127);
              print('============================');
              print(placemarks[0].country);
              print(placemarks[0].administrativeArea);
              print('============================');
            },
            icon: Icon(Icons.accessibility))
      ]),
    );
  }
}
