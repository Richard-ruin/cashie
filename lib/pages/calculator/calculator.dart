import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0"; // This will display the result
  String _expression = ""; // This stores the current input expression
  String _history =
      ""; // This will display the history (last evaluated expression)

  // Function to handle button presses
  void _onPressed(String value) {
    setState(() {
      if (value == "AC") {
        _output = "0";
        _expression = "";
        _history = "";
      } else if (value == "⌫") {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
          _output = _expression.isEmpty ? "0" : _expression;
        }
      } else if (value == "=") {
        try {
          _history = _expression; // Save the current expression as history
          _output = _evaluateExpression(_expression);
          _expression =
              _output; // Set the result as new expression for further calculations
        } catch (e) {
          _output = "Error";
        }
      } else {
        if (_output == "0" && value != ".") {
          _output = value;
        } else {
          _output += value;
        }
        _expression += value;
      }
    });
  }

  // Function to evaluate the expression
  String _evaluateExpression(String expression) {
    try {
      Parser parser = Parser();
      Expression exp =
          parser.parse(expression.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  Widget _buildButton(String value,
      {Color color = Colors.black, Color backgroundColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: value == '=' ? backgroundColor : Colors.white,
            foregroundColor: value == '=' ? color : color,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16.0),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          AppLocalizations.of(context)!.calculator,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(24.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _history,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _output,
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
                height: 0,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      _buildButton("(",
                          color: const Color.fromARGB(190, 10, 54, 173)),
                      _buildButton(")",
                          color: const Color.fromARGB(190, 10, 54, 173)),
                      _buildButton("%",
                          color: const Color.fromARGB(190, 10, 54, 173)),
                      _buildButton("AC",
                          color: const Color.fromARGB(190, 10, 54, 173)),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("÷",
                          color: const Color.fromARGB(190, 10, 54, 173)),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("×",
                          color: const Color.fromARGB(190, 10, 54, 173)),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-",
                          color: const Color.fromARGB(190, 10, 54, 173)),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("0"),
                      _buildButton(","),
                      _buildButton(
                        "+",
                        color: const Color.fromARGB(190, 10, 54, 173),
                      ),
                      _buildButton(
                        "=",
                        color: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
