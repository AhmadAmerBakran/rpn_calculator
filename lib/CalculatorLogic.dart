class RPNCalculator {
  List<double> _stack = [];

  void push(double value) {
    _stack.add(value);
  }

  double pop() {
    return _stack.removeLast();
  }

  void add() {
    double value1 = pop();
    double value2 = pop();
    push(value2 + value1);
  }

  void subtract() {
    double value1 = pop();
    double value2 = pop();
    push(value2 - value1);
  }

  void multiply() {
    double value1 = pop();
    double value2 = pop();
    push(value2 * value1);
  }

  void divide() {
    double value1 = pop();
    double value2 = pop();
    push(value2 / value1);
  }

  List<double> get stack => _stack;
}
