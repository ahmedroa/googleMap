import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormField({
  double width = double.infinity,
  // required Function function,
  required var textType,
  required TextInputType keyType,
  required String textt,
  // required String val ,
  bool pass = false,
  var value,
}) =>
    TextFormField(
      validator: value,
      onChanged: textType,
      keyboardType: keyType,
      obscureText: pass,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        labelText: textt,
        // suffixIcon: widget
      ),
    );
