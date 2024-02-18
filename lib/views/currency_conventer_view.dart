import 'package:calculator/models/currency_model.dart';
import 'package:calculator/services/currency_conventer_api.dart';
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

  List<Currency> currencyList = [];

  String fromCurrency = 'USD'; //Default value for base
  String toCurrency = 'EUR'; //Default value for convers

  final converterLogic = CurrencyConverterLogic();

  @override
  void initState() {
    super.initState();
    fetchCurrencies();
  }

  void buttonPressed(String buttonText) {
    var state = converterLogic.updateExpression(buttonText);
    setState(() {
      expression = state['expression']!;
      result = state['result']!;
    });
  }

  void onBaseCurrencyChange(String newBaseCurrency) async {
    await converterLogic.updateBaseCurrency(newBaseCurrency);
    setState(() {
      result = converterLogic.result;
    });
  }

  void onConversionCurrencyChange(String newConversionCurrency) async {
    converterLogic.onConversionCurrencyChange(newConversionCurrency);
    setState(() {
      result = converterLogic.result;
    });
  }

  void fetchCurrencies() async {
    try {
      currencyList = await CurrencyAPI().fetchCurrencies();
      setState(() {});
    } catch (e) {
      //
    }
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
              child: Column(
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

  // List with all available currencies

  void _showCurrencyPicker(bool isFromCurrency) {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 59, 59, 59),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(top: 20.sp),
          child: ListView.builder(
            itemCount: currencyList.length,
            itemBuilder: (BuildContext context, int index) {
              Currency currency = currencyList[index];
              return ListTile(
                title: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Row(
                    children: [
                      Text(
                        currency.code,
                        style: const TextStyle(color: Colors.orange),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Flexible(
                        // Use Flexible to prevent overflow
                        child: Text(
                          currency.name,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 199, 199, 199),
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Use ellipsis to handle text that still overflows
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (isFromCurrency) {
                      fromCurrency = currency.code;
                      onBaseCurrencyChange(fromCurrency);
                    } else {
                      toCurrency = currency.code;
                      onConversionCurrencyChange(toCurrency);
                    }
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              );
            },
          ),
        );
      },
    );
  }
}
