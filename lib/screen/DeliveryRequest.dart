import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mappp/constants/constants.dart';
import 'package:mappp/screen/ArrivalArea.dart';
import 'package:mappp/screen/home.dart';

class DeliveryRequest extends StatelessWidget {
  const DeliveryRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.to(home());
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: kBlueColor,
            )),
        title: Row(
          children: [
            Text(
              'البحث عن أماكن ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Icon(
              Icons.location_on,
              color: kBlueColor,
            ),
            TextButton(
                onPressed: () {
                  Get.to(ArrivalArea());
                },
                child: Text(
                  'تحديد على الخريطة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kBlueColor,
                  ),
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultTextFormField(
                Label: 'إبحث عن مكان', prefix: Icons.location_on),
            IntrinsicWidth(
              child: Column(
                children: [
                  Text(
                    'الأماكن المفضله',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 3,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.home,
                  color: kBlueColor,
                ),
                Text(
                  'المنزل',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    // color: kBlueColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
