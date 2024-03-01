abstract class Command {
  void apply(List<num> stack);
  void unApply(List<num> stack);
}

// Concrete command for pushing values
class PushCommand implements Command {
  final num value;

  PushCommand(this.value);

  @override
  void apply(List<num> stack) {
    stack.add(value);
  }

  @override
  void unApply(List<num> stack) {
    stack.removeLast();
  }
}

// Abstract command for operations
abstract class OperatorCommand implements Command {
  late num operand1;
  late num operand2;

  num operate(num operand1, num operand2);

  @override
  void apply(List<num> stack) {
    if (stack.length >= 2) {
      operand2 = stack.removeLast();
      operand1 = stack.removeLast();
      stack.add(operate(operand1, operand2));
    }
  }

  @override
  void unApply(List<num> stack) {
    stack.removeLast();
    stack.addAll([operand1, operand2]);
  }
}

// Concrete commands for add, subtract, multiply, and divide operations
class AddCommand extends OperatorCommand {
  @override
  num operate(num operand1, num operand2) => operand1 + operand2;
}

class SubtractCommand extends OperatorCommand {
  @override
  num operate(num operand1, num operand2) => operand1 - operand2;
}

class MultiplyCommand extends OperatorCommand {
  @override
  num operate(num operand1, num operand2) => operand1 * operand2;
}

class DivideCommand extends OperatorCommand {
  @override
  num operate(num operand1, num operand2) => operand1 / operand2;
}
