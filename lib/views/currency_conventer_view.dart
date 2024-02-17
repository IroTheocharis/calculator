import 'package:calculator/utils/currency_conventer_logic.dart';
import 'package:calculator/widgets/calc_button.dart';
import 'package:calculator/widgets/currency_display_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyConventerView extends StatefulWidget {
  const CurrencyConventerView({super.key});

  @override
  State<CurrencyConventerView> createState() => _CurrencyConventerViewState();
}

class _CurrencyConventerViewState extends State<CurrencyConventerView> {
  String expression = "0";
  String result = "";
  double currencyFontSize = 20.sp;
  double arithmeticFontSize = 30.sp;

  // Example currency list
  List<String> currencies = [
    'USD',
    'EUR',
    'GBP',
  ];
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';

  final converterLogic = CurrencyConverterLogic();
  void buttonPressed(String buttonText) {
    var state = converterLogic.updateExpression(buttonText);

    setState(() {
      expression = state['expression']!;
      result = state['result']!;
    });
  }

  // Example method to handle currency change
  void onCurrencyChange(double newRate) {
    converterLogic.updateConversionRate(newRate);

    setState(() {
      // Update UI to reflect changes from conversion rate update
      expression = converterLogic.expression;
      result = converterLogic.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Build the currency rows
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CurrencyDisplayRow(
                        currency: fromCurrency,
                        value: expression,
                        onPickerTap: () => _showCurrencyPicker(true),
                      ),
                      CurrencyDisplayRow(
                        currency: toCurrency,
                        value: result,
                        onPickerTap: () => _showCurrencyPicker(false),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Build the numbers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.white24, () => buttonPressed('7')),
                calcButton('8', Colors.white24, () => buttonPressed('8')),
                calcButton('9', Colors.white24, () => buttonPressed('9')),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.white24, () => buttonPressed('4')),
                calcButton('5', Colors.white24, () => buttonPressed('5')),
                calcButton('6', Colors.white24, () => buttonPressed('6')),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.white24, () => buttonPressed('1')),
                calcButton('2', Colors.white24, () => buttonPressed('2')),
                calcButton('3', Colors.white24, () => buttonPressed('3')),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton(' 0 ', Colors.white24, () => buttonPressed('0')),
                calcButton('.', Colors.white24, () => buttonPressed('.')),
                calcButton('⌫', Colors.orange, () => buttonPressed('⌫')),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  void _showCurrencyPicker(bool isFromCurrency) {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 59, 59, 59),
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                currencies[index],
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                setState(() {
                  if (isFromCurrency) {
                    fromCurrency = currencies[index];
                  } else {
                    toCurrency = currencies[index];
                  }
                });
                Navigator.pop(context); // Close the bottom sheet
              },
            );
          },
        );
      },
    );
  }
}
