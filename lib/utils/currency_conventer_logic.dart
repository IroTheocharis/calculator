import 'package:calculator/services/currency_conventer_api.dart';

class CurrencyConverterLogic {
  final CurrencyAPI currencyAPI = CurrencyAPI();
  String expression = "";
  String result = "";
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';

  // Utility function to check if a character is a numeric digit
  bool _isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  // Function to handle updates (numeric input, deletion, clear, etc.)
  Map<String, String> updateExpression(String buttonText) {
    if (buttonText == "⌫") {
      _deleteLast();
    } else {
      if (expression == "0" && buttonText != ".") {
        // Replace "0" with the number unless adding a decimal point to "0"
        expression = buttonText;
      } else if (buttonText == "." && !expression.contains(".")) {
        // Allow only one decimal point
        expression += buttonText;
      } else if (_isNumeric(buttonText)) {
        // Count only numeric digits, exclude decimal point or other characters
        int digitCount = expression.replaceAll(RegExp(r'[^0-9]'), '').length;
        if (digitCount < 15) {
          // Allow appending digits only if the total count is less than 15
          expression += buttonText;
        }
      }

      performConversion(); // Automatically perform conversion
    }
    return {'expression': expression, 'result': result};
  }

  // Perform conversion using the cached rate
  void performConversion() {
    double rate = currencyAPI.getConversionRate(toCurrency);
    double amount = double.tryParse(expression) ?? 0.0;
    double convertedAmount = amount * rate;
    result = convertedAmount.toStringAsFixed(2);
  }

  // Deletes the last character from the equation or resets it to "0"
  void _deleteLast() {
    if (expression.length > 1) {
      expression = expression.substring(0, expression.length - 1);
    } else {
      expression = "0";
    }
    performConversion();
  }

  // Initialize with fetching rates for the default base currency
  CurrencyConverterLogic() {
    updateBaseCurrency(fromCurrency);
  }

  // Call this when the base currency changes
  Future<void> updateBaseCurrency(String newBaseCurrency) async {
    await currencyAPI.fetchAndCacheRates(newBaseCurrency);
    fromCurrency = newBaseCurrency;
    performConversion(); // Perform conversion with updated rates
  }

  void onConversionCurrencyChange(String newConversionCurrency) {
    toCurrency = newConversionCurrency;
    performConversion(); // Use the cached rate for the new conversion currency to calculate the result
  }
}
