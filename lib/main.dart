import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp (MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SimpleCalculator(),
  ));
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText){
    setState((){
      if(buttonText == "C"){
        equation = "0";
        result = "0";
      }else if(buttonText == '⌫'){
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }else if(buttonText == "="){
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      }else{
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation += buttonText;}
      }
    });
  }

  Widget buildButton (String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontStyle: FontStyle.normal,
          ),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white,
                width: 1.0,
                style: BorderStyle.solid
            ),
          ),
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: (){
          buttonPressed(buttonText);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[800],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0,20.0,10.0,0.0),
            child: Text(equation,
            style: TextStyle(fontSize: equationFontSize, )),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0,20.0,10.0,0.0),
            child: Text(result,
                style: TextStyle(fontSize: resultFontSize, )),
          ),
          Expanded(
            child: Divider(
              //color: Colors.grey[800],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.redAccent),
                        buildButton('⌫', 1, Colors.blue),
                        buildButton('÷', 1, Colors.blue)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.grey[700]),
                        buildButton('8', 1, Colors.grey[700]),
                        buildButton('9', 1, Colors.grey[700])
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.grey[700]),
                        buildButton('5', 1, Colors.grey[700]),
                        buildButton('6', 1, Colors.grey[700])
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.grey[700]),
                        buildButton('2', 1, Colors.grey[700]),
                        buildButton('3', 1, Colors.grey[700])
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.grey[700]),
                        buildButton('0', 1, Colors.grey[700]),
                        buildButton('00', 1, Colors.grey[700])
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('×', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
