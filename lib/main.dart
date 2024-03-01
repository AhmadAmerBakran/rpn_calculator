import 'package:flutter/material.dart';

import 'CalculatorLogic.dart';
import 'Commands.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: RPNCalculatorUI(),
    );
  }
}

class RPNCalculatorUI extends StatefulWidget {
  @override
  _RPNCalculatorUIState createState() => _RPNCalculatorUIState();
}

class _RPNCalculatorUIState extends State<RPNCalculatorUI> {
  RPNCalculator calculator = RPNCalculator();
  String display = "";
  String currentInput = "";

  void _updateDisplay() {
    setState(() {
      display = calculator.stack.join(" ") + (currentInput.isEmpty ? "" : "\n$currentInput");
    });
  }

  void _onPressed(String value) {
    setState(() {
      if ('0123456789.'.contains(value)) {
        currentInput += value;
      } else if (value == "Enter" && currentInput.isNotEmpty) {
        calculator.executeCommand(PushCommand(double.parse(currentInput)));
        currentInput = "";
      } else if (value == "C") {
        calculator = RPNCalculator();
        currentInput = "";
      } else if (value == "←") {
        if (currentInput.isNotEmpty) {
          currentInput = currentInput.substring(0, currentInput.length - 1);
        }
      } else {
        if (currentInput.isNotEmpty) {
          calculator.executeCommand(PushCommand(double.parse(currentInput)));
          currentInput = "";
        }

        switch (value) {
          case "+":
            calculator.executeCommand(AddCommand());
            break;
          case "-":
            calculator.executeCommand(SubtractCommand());
            break;
          case "*":
            calculator.executeCommand(MultiplyCommand());
            break;
          case "/":
            calculator.executeCommand(DivideCommand());
            break;
        }
      }
      _updateDisplay();
    });
  }


  Widget _button(String label, {bool isOperation = false}) {
    return ElevatedButton(
      onPressed: () => _onPressed(label),
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isOperation ? Colors.orange : Colors.grey[850],
        foregroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        shape: CircleBorder(), // Circular buttons
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RPN Calculator'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.centerRight,
              child: Text(display, style: TextStyle(fontSize: 30, color: Colors.white)),
            ),
          ),
          GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1.0,
            padding: EdgeInsets.all(20),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            children: <String>[
              '7', '8', '9', '/',
              '4', '5', '6', '*',
              '1', '2', '3', '-',
              '0', '.', 'C', '+',
              'Enter', "←"
            ].map((label) {
              return GridTile(
                child: _button(label, isOperation: '+-*/EnterC←'.contains(label)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
