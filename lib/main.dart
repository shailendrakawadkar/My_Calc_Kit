import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonalCalculator(),
    );
  }
}

class PersonalCalculator extends StatefulWidget {
  @override
  _PersonalCalculatorState createState() => _PersonalCalculatorState();
}

class _PersonalCalculatorState extends State<PersonalCalculator> {
  String expression = '';
  String result = '0';
  void makeExpression(String a) {
    setState(() {
      expression = expression + a;
    });
  }

  void evaluateExpression() {
    Parser p = new Parser();
    expression = expression.replaceAll('X', '*');
    expression = expression.replaceAll('÷', '/');
    Expression exp = p.parse(expression);
    setState(() {
      result = exp
          .evaluate(EvaluationType.REAL, null)
          .toString(); // if context is not available replace it with null.
    });
  }

  Widget button(String a) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          if (a == 'AC') {
            setState(() {
              expression = '';
            });
          } else if (a == '←') {
            setState(() {
              expression = expression.trimRight();
            });
          } else
            (a == '=') ? evaluateExpression() : makeExpression(a);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.lightBlueAccent,
              width: 1.2,
              style: BorderStyle.solid,
            ),
            color: Colors.black,
          ),
          child: Center(
              child: Text(
            a,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
      ),
    );
  }

  final equ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        expression,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          result,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: button('AC')),
                          Expanded(flex: 1, child: button('←')),
                          Expanded(flex: 1, child: button('+/-')),
                          Expanded(flex: 1, child: button('÷')),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: button('7')),
                          Expanded(flex: 1, child: button('8')),
                          Expanded(flex: 1, child: button('9')),
                          Expanded(flex: 1, child: button('X')),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: button('4')),
                          Expanded(flex: 1, child: button('5')),
                          Expanded(flex: 1, child: button('6')),
                          Expanded(flex: 1, child: button('-')),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: button('1')),
                          Expanded(flex: 1, child: button('2')),
                          Expanded(flex: 1, child: button('3')),
                          Expanded(flex: 1, child: button('+')),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: button('0')),
                          Expanded(flex: 1, child: button('00')),
                          Expanded(flex: 1, child: button('.')),
                          Expanded(flex: 1, child: button('=')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
