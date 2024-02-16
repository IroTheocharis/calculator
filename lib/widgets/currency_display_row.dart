import 'package:calculator/widgets/currency_display_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyDisplayRow extends StatelessWidget {
  final String currency;
  final String value;
  final VoidCallback onPickerTap;

  const CurrencyDisplayRow({
    Key? key,
    required this.currency,
    required this.value,
    required this.onPickerTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CurrencyPickerButton(currency: currency, onTap: onPickerTap),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 30.sp, color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
