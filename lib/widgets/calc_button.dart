import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget calcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: buttonText == "0" ? 160.w : 75.w,
    height: 70.h,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.sp))),
          backgroundColor: buttonColor),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20.sp, color: Colors.white),
      ),
    ),
  );
}
