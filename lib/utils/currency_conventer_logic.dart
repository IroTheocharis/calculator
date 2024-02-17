class CurrencyConverterLogic {
  String expression = "";
  String result = "";
  double conversionRate = 3.3; // Default conversion rate, update as needed

  // Utility function to check if a character is a numeric digit
  bool _isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  // Function to handle updates (numeric input, deletion, clear, etc.)
  Map<String, String> updateExpression(String buttonText) {
    if (buttonText == "⌫") {
      _deleteLast();
    } else if (_isNumeric(buttonText) || buttonText == ".") {
      if (expression == "0" && buttonText != ".") {
        // Replace "0" with the number unless adding a decimal point to "0"
        expression = buttonText;
      } else {
        // Append the button text to the expression
        expression += buttonText;
      }

      _performConversion(); // Automatically perform conversion
    }
    return {'expression': expression, 'result': result};
  }

  void _performConversion() {
    if (expression.isNotEmpty) {
      double amount = double.tryParse(expression) ?? 0.0;
      double convertedAmount = amount * conversionRate;
      result = convertedAmount.toStringAsFixed(2);
    }
  }

  // Deletes the last character from the equation or resets it to "0"
  void _deleteLast() {
    if (expression.length > 1) {
      expression = expression.substring(0, expression.length - 1);
    } else {
      expression = "0";
    }
    _performConversion();
  }

  // Method to update conversion rate (call this when currencies change)
  void updateConversionRate(double newRate) {
    conversionRate = newRate;
    _performConversion(); // Re-calculate conversion with new rate
  }
}
