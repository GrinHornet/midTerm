import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _currentNumber = '';
  String _operation = '';
  String _expression = '';
  double _result = 0;
  String _prevNumber = '';
  bool _isResultDisplayed = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _output = '0';
        _currentNumber = '';
        _operation = '';
        _expression = '';
        _result = 0;
        _prevNumber = '';
        _isResultDisplayed = false;
      } else if (value == '=') {
        if (_operation.isNotEmpty && _currentNumber.isNotEmpty) {
          double num = double.parse(_currentNumber);
          switch (_operation) {
            case '+':
              _result += num;
              break;
            case '-':
              _result -= num;
              break;
            case 'x':
              _result *= num;
              break;
            case '/':
              _result /= num;
              break;
          }
          _output = _result.toString();
          _expression = '$_prevNumber $_operation $_currentNumber = $_output';
          _currentNumber = '';
          _operation = '';
          _prevNumber = '';
          _isResultDisplayed = true;
        }
      } else if (value == '+' || value == '-' || value == 'x' || value == '/') {
        if (_isResultDisplayed) {
          _prevNumber = _output;
          _result = double.parse(_output);
          _currentNumber = '';
          _isResultDisplayed = false;
        } else if (_currentNumber.isNotEmpty) {
          _prevNumber = _currentNumber;
          _result = double.parse(_currentNumber);
        }
        _operation = value;
        _expression = '$_prevNumber $value';
        _currentNumber = '';
        _output = '0';
      } else {
        if (_isResultDisplayed) {
          _output = '0';
          _currentNumber = '';
          _operation = '';
          _expression = '';
          _result = 0;
          _prevNumber = '';
          _isResultDisplayed = false;
        }
        _currentNumber += value;
        _output = _currentNumber;
        if (_operation.isNotEmpty) {
          _expression = '$_prevNumber $_operation $_currentNumber';
        } else {
          _expression += value;
        }
      }
    });
  }

  Widget _buildButton(String label, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(1.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered)) {
                return color.withOpacity(0.7);
              }
              return color;
            }),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 24.0)),
          ),
          onPressed: () {
            _onButtonPressed(label);
          },
          child: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              color: Colors.blue[100],
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  _expression,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
              color: Color.fromARGB(255, 174, 232, 252),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildButton('7', Colors.blue[300]!),
                  _buildButton('8', Colors.blue[300]!),
                  _buildButton('9', Colors.blue[300]!),
                  _buildButton('/', Colors.blue[300]!),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildButton('4', Colors.blue[300]!),
                  _buildButton('5', Colors.blue[300]!),
                  _buildButton('6', Colors.blue[300]!),
                  _buildButton('x', Colors.blue[300]!),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildButton('1', Colors.blue[300]!),
                  _buildButton('2', Colors.blue[300]!),
                  _buildButton('3', Colors.blue[300]!),
                  _buildButton('-', Colors.blue[300]!),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildButton('C', Colors.blue[300]!),
                  _buildButton('0', Colors.blue[300]!),
                  _buildButton('=', Colors.blue[300]!),
                  _buildButton('+', Colors.blue[300]!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
