import 'Commands.dart';

class RPNCalculator {
  List<num> _stack = [];

  void executeCommand(Command command) {
    command.apply(_stack);
  }

  List<num> get stack => _stack;
}
