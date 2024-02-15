import 'package:calculator/widgets/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleCalculatorView extends StatefulWidget {
  const SimpleCalculatorView({super.key});

  @override
  State<SimpleCalculatorView> createState() => _SimpleCalculatorViewState();
}

class _SimpleCalculatorViewState extends State<SimpleCalculatorView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.sp;
  double resultFontSize = 48.sp;

  buttonPressed(String buttonText) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,

                  // Build the result and the equation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Text(
                          equation,
                          style: TextStyle(
                            fontSize: equationFontSize,
                            color: Colors.white38,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          ' = $result ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: resultFontSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                ),
              ),
            ),

            // Build the calculator numbers & operators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.white54, () => buttonPressed('AC')),
                calcButton("⌫", Colors.white54, () => buttonPressed("⌫")),
                calcButton('%', Colors.white54, () => buttonPressed('%')),
                calcButton('÷', Colors.orange, () => buttonPressed('÷')),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.white24, () => buttonPressed('7')),
                calcButton('8', Colors.white24, () => buttonPressed('8')),
                calcButton('9', Colors.white24, () => buttonPressed('9')),
                calcButton("×", Colors.orange, () => buttonPressed('×')),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.white24, () => buttonPressed('4')),
                calcButton('5', Colors.white24, () => buttonPressed('5')),
                calcButton('6', Colors.white24, () => buttonPressed('6')),
                calcButton('-', Colors.orange, () => buttonPressed('-')),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.white24, () => buttonPressed('1')),
                calcButton('2', Colors.white24, () => buttonPressed('2')),
                calcButton('3', Colors.white24, () => buttonPressed('3')),
                calcButton('+', Colors.orange, () => buttonPressed('+')),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('0', Colors.white24, () => buttonPressed('0')),
                calcButton('.', Colors.white24, () => buttonPressed('.')),
                calcButton('=', Colors.orange, () => buttonPressed('=')),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
