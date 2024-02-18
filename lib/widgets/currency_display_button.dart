import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyPickerButton extends StatelessWidget {
  final String currency;
  final VoidCallback onTap;

  const CurrencyPickerButton({
    Key? key,
    required this.currency,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          Text(currency,
              style: TextStyle(fontSize: 20.sp, color: Colors.white)),
          const Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
    );
  }
}
