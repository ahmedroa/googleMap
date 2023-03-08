import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappp/constants/constants.dart';
import 'package:mappp/screen/DeliveryRequest.dart';

class request extends StatefulWidget {
  const request({
    Key? key,
  }) : super(key: key);

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  List<String> _tags = [
    "سيارة  ",
    "فان",
    "موتر",
    "توصيل",
    // "سيارة",
  ];
  List<String> _tagsn = [
    "1-4  ",
    "1-8",
    "1",
    "-",
    // "سيارة",
  ];
  int selectedTag = 0;
  Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTag = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: selectedTag == index ? kBlueColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            // Image.asset(
            //   'images/H.png',
            //   height: 30,
            //   width: 60,
            // ),
            Column(
              children: [
                // Text(
                //   _tags[index],
                //   style: TextStyle(
                //     color:
                //         selectedTag != index ? Colors.grey[400] : Colors.white,
                //     fontFamily: 'Poppins',
                //   ),
                // ),
                // Text(
                //   _tagsn[index],
                //   style: TextStyle(
                //     color:
                //         selectedTag != index ? Colors.grey[400] : Colors.white,
                //     fontFamily: 'Poppins',
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE7EBF2),
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Eveing Abhinav!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              defaultTextFormField(
                Label: 'Where you going ?',
              ),
              Text(
                'last trips',
                style: TextStyle(fontSize: 16),
              ),
              Button(
                function: () {},
                text: 'Locate on the map',
                Color: Colors.grey[400],
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: _tags
              //       .asMap()
              //       .entries
              //       .map((MapEntry map) => _buildTags(map.key))
              //       .toList(),
              // ),
              // SizedBox(height: 10),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: ((context) => DeliveryRequest())));
              //   },
              //   child: Container(
              //     decoration: (BoxDecoration(
              //       color: Colors.grey[300],
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10),
              //       ),
              //     )),
              //     height: 50,
              //     // child: Row(children: [
              //     //   Icon(Icons.location_on_outlined),
              //     //   Text('تحديد المكان ')
              //     // ]),
              //   ),
              // ),
              // SizedBox(height: 10),

              // // SizedBox(height: 10),
              // // defaultButton(
              // //   text: 'مشوار مفتوح',
              // //   function: () {},
              // // ),
            ]),
      ),
    );
  }
}
