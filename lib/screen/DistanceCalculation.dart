import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';

class DistanceCalculation extends StatefulWidget {
  const DistanceCalculation({Key? key}) : super(key: key);

  @override
  State<DistanceCalculation> createState() => _DistanceCalculationState();
}

class _DistanceCalculationState extends State<DistanceCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                var distanceBetween = Geolocator.distanceBetween(
                    15.512403, 32.595981, 15.577493, 32.550844);
                var distanceKm = distanceBetween / 1000;
                print(distanceKm);
              },
              child: Text('data'))
        ],
      ),
    );
  }
}
