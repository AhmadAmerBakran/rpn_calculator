import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calculator/CalculatorLogic.dart';
import 'package:rpn_calculator/Commands.dart';

void main() {
  group('PushCommand Tests', () {
    test('Should push a value onto the stack', () {
      final stack = <num>[];
      final pushCommand = PushCommand(5);

      pushCommand.apply(stack);

      expect(stack, contains(5));
    });
  });

  group('AddCommand Tests', () {
    test('Should add two numbers', () {
      final stack = <num>[1, 2];
      final addCommand = AddCommand();

      addCommand.apply(stack);

      expect(stack.last, 3);
    });
  });

  group('RPNCalculator Tests with AddCommand', () {
    test('Should correctly execute a sequence of commands', () {
      final calculator = RPNCalculator();
      calculator.executeCommand(PushCommand(3));
      calculator.executeCommand(PushCommand(4));
      calculator.executeCommand(AddCommand());

      expect(calculator.stack.last, 7);
    });
  });

  group('RPNCalculator Tests with SubtractCommand', () {
    test('Should correctly execute a sequence of commands', () {
      final calculator = RPNCalculator();
      calculator.executeCommand(PushCommand(3));
      calculator.executeCommand(PushCommand(4));
      calculator.executeCommand(SubtractCommand());

      expect(calculator.stack.last, -1);
    });
  });

  group('RPNCalculator Tests with MultiplyCommand', () {
    test('Should correctly execute a sequence of commands', () {
      final calculator = RPNCalculator();
      calculator.executeCommand(PushCommand(3));
      calculator.executeCommand(PushCommand(4));
      calculator.executeCommand(MultiplyCommand());

      expect(calculator.stack.last, 12);
    });
  });

  group('RPNCalculator Tests with DivideCommand', () {
    test('Should correctly execute a sequence of commands', () {
      final calculator = RPNCalculator();
      calculator.executeCommand(PushCommand(50));
      calculator.executeCommand(PushCommand(5));
      calculator.executeCommand(DivideCommand());

      expect(calculator.stack.last, 10);
    });
  });

}

