import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF219ebc);
const kSecondaryColor = Color(0xFFfcca46);
const kTextColor = Color(0xFF023047);
const kTextLightColor = Color(0xFF747474);
// const kBlueColor = Color(0xff4c53a5);
const kBlueColor = Color(0XFF636CBE);

const kDefaultPadding = 20.0;

Widget defaultTextFormField({
  var onChanged,
  TextEditingController? controller,
  TextInputType? keyboaredType,
  IconData? prefix,
  var initialValue,
  required String Label,
  FormFieldValidator? validator,
  Function? onSubmitted,
  GestureTapCallback? ontap,
  IconData? suffix,
  bool? obsecure = false,
}) {
  return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboaredType,
      obscureText: obsecure!,
      maxLines: 1,
      enableSuggestions: true,
      onFieldSubmitted: (s) {
        onSubmitted!();
      },
      onTap: ontap,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: Icon(suffix),
        labelText: Label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ));
}

Widget defaultButton({
  required String text,
  required var function,
}) {
  return Container(
    // width: double.infinity,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: kBlueColor,
    ),
  );
}

Widget line({
  var function,
}) {
  return Container(
      width: double.infinity, height: 3.0, color: Colors.grey[300]);
}

Widget type({
  required String test1,
  required String test2,
}) {
  return Row(
    children: [
      Text(
        test1,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Spacer(),
      Text(
        test2,
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ],
  );
}

Widget Button({
  required var function,
  required String text,
  var Color = kTextColor,
}) =>
    Container(
      width: double.infinity,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20.0),
      //   color: Color,
      // ),
    );
