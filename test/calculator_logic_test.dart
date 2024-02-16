import 'package:calculator/utils/calc_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator Operations', () {
    test('Addition', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('5');
      calculator.buttonPressed('+');
      calculator.buttonPressed('3');
      calculator.buttonPressed('=');

      expect(calculator.result, '8');
    });

    test('Addition of two large numbers', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('111111111111111');
      calculator.buttonPressed('+');
      calculator.buttonPressed('111111111111111');
      calculator.buttonPressed('=');

      // Expect to use a scientific notation for too large numbers
      expect(calculator.result, '2.222222e+14');
    });

    test('Addition of decimal numbers', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('5.1');
      calculator.buttonPressed('+');
      calculator.buttonPressed('6.5');
      calculator.buttonPressed('+');
      calculator.buttonPressed('1.3');
      calculator.buttonPressed('=');

      // Expect to use a scientific notation for too large numbers
      expect(calculator.result, '12.9');
    });

    test('Subtraction', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('5');
      calculator.buttonPressed('-');
      calculator.buttonPressed('3');
      calculator.buttonPressed('=');

      expect(calculator.result, '2');
    });

    test('Percentage in an addition', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('100');
      calculator.buttonPressed('+');
      calculator.buttonPressed('10');
      calculator.buttonPressed('%');
      calculator.buttonPressed('=');

      expect(calculator.result, '110');
    });

    test('Percentage in an multiplication', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('100');
      calculator.buttonPressed('×');
      calculator.buttonPressed('10');
      calculator.buttonPressed('%');
      calculator.buttonPressed('=');

      expect(calculator.result, '10');
    });

    test('Multiplication', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('4');
      calculator.buttonPressed('×');
      calculator.buttonPressed('10');
      calculator.buttonPressed('=');

      expect(calculator.result,
          '40'); // Assuming your logic directly modifies the result
    });

    test('Division', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('4');
      calculator.buttonPressed('÷');
      calculator.buttonPressed('10');
      calculator.buttonPressed('=');

      expect(calculator.result,
          '0.4'); // Assuming your logic directly modifies the result
    });

    test('Clear AC', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('4');
      calculator.buttonPressed('÷');
      calculator.buttonPressed('10');
      calculator.buttonPressed('AC');
      calculator.buttonPressed('=');

      expect(calculator.result,
          '0'); // Assuming your logic directly modifies the result
    });

    test('Expression ends with operator', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('4');
      calculator.buttonPressed('+');
      calculator.buttonPressed('10');
      calculator.buttonPressed('+');
      calculator.buttonPressed('=');

      expect(calculator.result,
          '14'); // Assuming your logic directly modifies the result
    });

    test('Append operator after another operator', () {
      final calculator = CalculatorLogic();
      calculator.buttonPressed('4');
      calculator.buttonPressed('+');
      calculator.buttonPressed('-');
      calculator.buttonPressed('10');
      calculator.buttonPressed('=');

      expect(calculator.result,
          '-6'); // Assuming your logic directly modifies the result
    });
  });
}
