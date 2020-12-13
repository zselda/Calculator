import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}


class _CalculatorPageState extends State<CalculatorPage> {
  String equation = '0';
  String result = '0';
  String expression = '';

  onDigitPress(String text){
    setState(() {
      if(text == 'C'){
        equation = '0';
        result = '0';
      }
      else if(text == '⌫'){
        equation = equation.substring(0, equation.length -1);
        if(equation == ''){
          equation = '0';
        }
      }
      else if(text == '='){
        expression = equation;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('×', '*');

        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch(e){
          result = 'Error!';
        }

      }
      else {
        if (equation == '0') {
          equation = text;
        } else {
          equation = equation + text;
        }
      }
    });
  }

  /**double result = 0.0;
  String strResult='0';
  String operator = '';
  double firstNum;

  void onDigitPress(String text){
    print('digit pressed $text');
    if(text== '+'){
      operator = text;
      firstNum = result;
      result = 0;
      strResult = '';
      setState(() {
        result = 0;
      });
    }
    else if (text == '='){
      switch (operator) {
        case '+':
          setState(() {
            result = result + firstNum;
          });
          strResult = '$result';
      }
    }
    else{
      var tempResult = strResult + text;
      var temp = double.tryParse(tempResult);
      if(temp != null){
        strResult = tempResult;
        setState(() {
          result = temp ?? result;
        });
      }

    }

  }**/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
          title: Text ('Calculator')
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),

        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                  child: Text(
                    '$equation',
                  style: TextStyle(fontSize: 40, color : Colors.deepPurple),

                ),
            ),
        ),
          Expanded(
               child: Container(
                 alignment: Alignment.centerRight,
                 child: Text(
                  '$result',
                   style: TextStyle(fontSize: 60, color : Colors.deepPurple),
            ),
               )
            ),
            Expanded(child: Divider(
              color: Colors.deepPurple[400],
              thickness: 1,
              indent: 20,
              endIndent: 20,

            )
            ),
            Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildCalcuButton('C', Colors.purple[300]),
                      buildCalcuButton('⌫',Colors.deepPurple[300]),
                      buildCalcuButton('÷', Colors.deepPurple[300]),
                    ]
                )
            ),
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildCalcuButton('7', Colors.deepPurple[200]),
                    buildCalcuButton('8', Colors.deepPurple[200]),
                    buildCalcuButton('9', Colors.deepPurple[200]),
                    buildCalcuButton('×', Colors.deepPurple[300])
              ]
            )
          ),
            Expanded(
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcuButton('4', Colors.deepPurple[200]),
                  buildCalcuButton('5', Colors.deepPurple[200]),
                  buildCalcuButton('6', Colors.deepPurple[200]),
                  buildCalcuButton('+', Colors.deepPurple[300])
                ],
              )
            ),
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildCalcuButton('1', Colors.deepPurple[200]),
                    buildCalcuButton('2', Colors.deepPurple[200]),
                    buildCalcuButton('3', Colors.deepPurple[200]),
                    buildCalcuButton('-', Colors.deepPurple[300])
                  ],
                )
            ),
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildCalcuButton('.', Colors.deepPurple[400]),
                    buildCalcuButton('0', Colors.deepPurple[400]),
                    buildCalcuButton('00', Colors.deepPurple[400]),
                    buildCalcuButton('=', Colors.deepPurple[300])
                  ],
                )
            )

          ],
        ),
      )
    );
  }

  Expanded buildCalcuButton(String text, Color color) {
    return Expanded(
        child: FlatButton(
          onPressed: () {
            onDigitPress(text);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side : BorderSide(
                color: Colors.black54,
                width: 0.75,
                style: BorderStyle.solid,
              )
            ),
          color: color,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 30,
                color: Colors.white),
                ),
              )
              );
  }
}
