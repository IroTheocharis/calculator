import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  String equation = "0";
  String result = "0";
  String expression = "";

  // Utility function to check if a character is a numeric digit
  bool _isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  // Function to handle button presses
  Map<String, String> buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _clear();
    } else if (buttonText == "⌫") {
      _deleteLast();
    } else if (buttonText == "%") {
      _applyPercentage();
    } else if (buttonText == "=") {
      _calculateResult();
    } else {
      _updateEquation(buttonText);
    }
    return {'equation': equation, 'result': result};
  }

  // Clears the equation and result
  void _clear() {
    equation = "0";
    result = "0";
  }

  // Deletes the last character from the equation or resets it to "0"
  void _deleteLast() {
    if (equation.length > 1) {
      equation = equation.substring(0, equation.length - 1);
    } else {
      equation = "0";
    }
  }

  // Follows the android calculator logic when the botton % is pressed
  void _applyPercentage() {
    // Check if the equation ends with a number
    if (!_isNumeric(equation[equation.length - 1])) {
      // If not, remove the last operator (no operation needed for a trailing operator)
      equation = equation.substring(0, equation.length - 1);
    }

    // Identify the last operation and the number preceding the percentage operation
    RegExp regExp = RegExp(r'([+\-×÷])(\d+(?:\.\d+)?)$');
    Match? match = regExp.firstMatch(equation);

    if (match != null) {
      String lastOperator = match.group(1)!;
      double lastNumber = double.parse(match.group(2)!);
      double percentageValue = lastNumber / 100;

      // For addition and subtraction, calculate the percentage of the first number in the operation
      if (lastOperator == '+' || lastOperator == '-') {
        RegExp firstNumberExp = RegExp(r'(\d+(?:\.\d+)?)');
        Match? firstNumberMatch =
            firstNumberExp.firstMatch(equation.substring(0, match.start));
        if (firstNumberMatch != null) {
          double firstNumber = double.parse(firstNumberMatch.group(0)!);
          percentageValue = (lastNumber / 100) * firstNumber;
        }
      }

      // Replace the last number with its percentage equivalent
      equation = equation.substring(0, match.start) +
          lastOperator +
          percentageValue.toString();
    } else {
      // If no operator is found, treat the whole number as a percentage of 100 (for standalone percentage operations)
      double number = double.tryParse(equation) ?? 0;
      equation = (number / 100).toString();
    }
  }

  // Claculate the result using the math_expressions package
  void _calculateResult({bool applyPercentage = false}) {
    expression = equation;
    expression = expression.replaceAll('×', '*').replaceAll('÷', '/');

    try {
      // Check if the last character of the expression is an operator
      if (expression.isNotEmpty &&
          !_isNumeric(expression[expression.length - 1])) {
        // Remove the last character from the equation
        expression = expression.substring(0, expression.length - 1);
      }

      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (applyPercentage) {
        // Apply percentage to the whole equation result
        eval /= 100;
      }

      // Use the formatResult function to format the result
      result = formatResult(eval);
    } catch (e) {
      result = "Error";
    }
  }

  String formatResult(double eval) {
    // Intermediate rounding to address floating-point arithmetic issues
    // Determine if rounding is necessary based on the operation's context (e.g., addition)
    double roundedEval =
        (eval * 1e12).round() / 1e12; // Example: round to 12 decimal places

    // Convert the result to a string
    String resultStr = roundedEval.toString();

    // Check if the result includes a decimal point and remove trailing zeros and decimal point if necessary
    if (resultStr.contains('.')) {
      resultStr =
          resultStr.replaceAll(RegExp(r'0*$'), ''); // Remove trailing zeros
      resultStr = resultStr.replaceAll(
          RegExp(r'\.$'), ''); // Remove trailing decimal point if any
    }

    // Use scientific notation for numbers that are too long or if the number is a floating point with more than 4 decimal digits
    if (resultStr.length > 12 ||
        (resultStr.contains('.') && resultStr.split('.')[1].length > 4)) {
      // Format to scientific notation with a precision that ensures the total length is up to 12 characters
      // Note: Adjusting precision while ensuring the total length, including exponent, does not exceed 12 characters can be complex due to variable exponent length
      // A straightforward approach is to use a fixed precision that typically fits, then trim if necessary
      int precision = resultStr.length - 12 >= 0 ? 12 : resultStr.length;
      resultStr = eval.toStringAsExponential(precision);

      // Further adjust if the formatted string still exceeds 12 characters, typically due to long exponents
      if (resultStr.length > 12) {
        // Find a suitable precision that accommodates the exponent while keeping the total length to 12 or less
        int adjustPrecision = precision - (resultStr.length - 12);
        resultStr = eval
            .toStringAsExponential(adjustPrecision > 0 ? adjustPrecision : 0);
      }
    }

    return resultStr;
  }

  // Updates the equation string based on the button pressed by the user.
  // - If the current equation is "0" and a numeric button is pressed, it replaces "0" with the number.
  // - If both the last character in the equation and the button pressed are operators,
  //   it replaces the last operator with the new one to prevent consecutive operators.
  // - In all other cases, it appends the button text to the current equation.

  void _updateEquation(String buttonText) {
    // Directly replace "0" with the number, unless it's a decimal point being added to "0".
    if (equation == "0") {
      if (_isNumeric(buttonText)) {
        equation = buttonText;
      } else {
        // For operators, just append since "0" could be a valid operand
        equation += buttonText;
      }
    } else {
      bool isLastCharOperator = !_isNumeric(equation[equation.length - 1]) &&
          equation[equation.length - 1] != '.';
      bool isButtonOperator = !_isNumeric(buttonText) || buttonText == '.';

      // Extract the current number for digit count checks
      List<String> parts = equation.split(RegExp(r'[\+\-×÷]'));
      String currentNumber = parts.last;
      bool hasDecimal = currentNumber.contains('.');
      int decimalIndex = currentNumber.indexOf('.');
      int decimalLength =
          hasDecimal ? currentNumber.length - decimalIndex - 1 : 0;
      int integerLength = hasDecimal ? decimalIndex : currentNumber.length;

      // Check if both the last character of the equation and the button pressed are operators
      if (isLastCharOperator && isButtonOperator) {
        // Replace the last operator with the new one if two operators are pressed consecutively
        equation = equation.substring(0, equation.length - 1) + buttonText;
      } else if (_isNumeric(buttonText) || buttonText == ".") {
        // Prevent adding more digits or a decimal point if limits are reached
        if (buttonText == "." && !hasDecimal) {
          equation += buttonText; // Allow decimal if not present
        } else if (_isNumeric(buttonText)) {
          if (hasDecimal && decimalLength < 4) {
            equation += buttonText; // Append if decimal part < 4 digits
          } else if (!hasDecimal && integerLength < 15) {
            equation += buttonText; // Append if integer part < 15 digits
          }
          // Implicitly ignore input if limits are exceeded
        }
      } else {
        // Append non-numeric buttons (operators) directly
        equation += buttonText;
      }
    }
  }
}
