import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../manager/constant.dart';

Widget Textfieldup({
  required TextEditingController myTimeController,
  required BuildContext context,
  required IconData myicon,
  required VoidCallback ontap,
  required TextInputType keyboardtype,
  required String Lable,
  required FormFieldValidator<String> validator,
}) {
  return TextFormField(
    validator: validator,
    style: mystyle.copyWith(
      fontSize: 20,
      color: Colors.white,
    ),
    cursorColor: textcolor,
    decoration: InputDecoration(
      filled: true,
      fillColor: primaypcolor,
      focusColor: Colors.redAccent,
      prefixIcon: Icon(myicon, color: textcolor),
      label: Text(Lable, style: mystyle.copyWith(fontSize: 15)),
      floatingLabelStyle: mystyle.copyWith(fontSize: 10),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textcolor, width: 3)),
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textcolor, width: 2),
          borderRadius: BorderRadius.circular(20)),
    ),
    controller: myTimeController,
    keyboardType: keyboardtype,
    onTap: ontap,
  );
}
