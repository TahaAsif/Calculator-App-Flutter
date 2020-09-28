import 'package:calculatorApp/UI/CalculatorButtons.dart';
import 'package:calculatorApp/UI/valueDisplay.dart';
import 'package:flutter/material.dart';

class CalculatorDisplay extends StatefulWidget {
  CalculatorDisplay({Key key}) : super(key: key);

  @override
  _CalculatorDisplayState createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  String _output;
  String firstNumber;
  String secondNumber;
  String operator;
  Color buttonColor = Colors.black;
  Color numberButtonColor = Colors.white;
  Color valueDisplayColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    //Below colors are always fixed
    Color operatorButtonColor = Colors.orange;
    Color specialButtonColor = Colors.grey;

    return Container(
      color: buttonColor,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                switchThemeColor();
              });
            },
            child: ValueDisplay(
              text: _getDisplayText(),
              backgroundColor: buttonColor,
              textColor: valueDisplayColor,
            ),
          ),
          Row(
            children: [
              getCalculatorButton(
                  "AC", () => clear(), buttonColor, specialButtonColor, 80, 80),
              getCalculatorButton("+/-", () => {onOperatorTapped("+/-")},
                  buttonColor, specialButtonColor, 80, 80),
              getCalculatorButton("%", () => {onOperatorTapped("%")},
                  buttonColor, specialButtonColor, 80, 80),
              getCalculatorButton("/", () => {onOperatorTapped("/")},
                  buttonColor, specialButtonColor, 80, 80)
            ],
          ),
          Row(
            children: [
              getCalculatorButton("7", () => {onNumberTapped("7")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("8", () => {onNumberTapped("8")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("9", () => {onNumberTapped("9")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("x", () => {onOperatorTapped("x")},
                  buttonColor, operatorButtonColor, 80, 80)
            ],
          ),
          Row(
            children: [
              getCalculatorButton("4", () => {onNumberTapped("4")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("5", () => {onNumberTapped("5")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("6", () => {onNumberTapped("6")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("-", () => {onOperatorTapped("-")},
                  buttonColor, operatorButtonColor, 80, 80)
            ],
          ),
          Row(
            children: [
              getCalculatorButton("1", () => {onNumberTapped("1")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("2", () => {onNumberTapped("2")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("3", () => {onNumberTapped("3")}, buttonColor,
                  numberButtonColor, 80, 80),
              getCalculatorButton("+", () => {onOperatorTapped("+")},
                  buttonColor, operatorButtonColor, 80, 80)
            ],
          ),
          Row(
            children: [
              getCalculatorButton("0", () => {onNumberTapped("0")}, buttonColor,
                  numberButtonColor, 170, 80),
              getCalculatorButton(".", () => {onOperatorTapped(".")},
                  buttonColor, numberButtonColor, 80, 80),
              getCalculatorButton("=", () => {calculateResult()}, buttonColor,
                  operatorButtonColor, 80, 80),
            ],
          )
        ],
      ),
    );
  }

// This function is responsible for switching theme color
  void switchThemeColor() {
    if (buttonColor == Colors.black) {
      buttonColor = Colors.white;
      numberButtonColor = Colors.black;
      valueDisplayColor = Colors.black;
    } else {
      buttonColor = Colors.black;
      numberButtonColor = Colors.white;
      valueDisplayColor = Colors.white;
    }
  }

// This function is responsible for setting number or if needed to append a number (multidigit number) then call proper setDemicalAccordingly
  void onNumberTapped(String number) {
    setState(() {
      if (_output != null) {
        _output = null;
        firstNumber = number;
        return;
      }

      if (firstNumber == null) {
        firstNumber = number;
        return;
      }

      if (operator == null) {
        if (checkLength(firstNumber)) {
          firstNumber = '$firstNumber$number';
        }
        return;
      }

      if (secondNumber == null) {
        secondNumber = number;
        return;
      }

      if (checkLength(secondNumber)) {
        secondNumber = '$secondNumber$number';
        return;
      }
    });
  }

// // This function will remove a zero which was appended due to decimal insertion
//   num setDemicalAccordingly(num number, num numberToConcatenate) {
//     num toReturn = number;

//     if (number.toString().contains(".")) {
//       // shows decimalNumber
//       toReturn = num.parse('$number$numberToConcatenate');
//       String numberString = toReturn.toString();
//       numberString = numberString.replaceAll(".0", ".");
//       toReturn = num.parse(numberString);
//     } else {
//       toReturn = num.parse('$number$numberToConcatenate');
//     }
//     return toReturn;
//   }

// This function is responsible for appending operator or number accordingly
  void onOperatorTapped(String operator) {
    setState(() {
      if (_output != null) {
        firstNumber = _output;
        _output = null;
      } else if (firstNumber == null) {
        firstNumber = '0';
      }

      if (operator == ".") {
        if (this.operator == null && !firstNumber.toString().contains(".")) {
          firstNumber = '$firstNumber$operator';
        } else if (secondNumber != null &&
            !secondNumber.toString().contains(".")) {
          secondNumber = '$secondNumber$operator';
        }
      } else if (operator == "+/-") {
        firstNumber = (-(double.parse(firstNumber))).toString();
      } else {
        this.operator = operator;
      }
    });
  }

// This function is responsible for calculation of result of "=" sign pressed
  calculateResult() {
    if (operator == null || (secondNumber == null && operator != "%")) {
      return;
    }

    num firstValue = num.parse(firstNumber);
    num secondValue = null;
    if (secondNumber != null) {
      secondValue = num.parse(secondNumber);
    }
    setState(() {
      switch (operator) {
        case "+":
          _output = (firstValue + secondValue).toString();
          break;
        case '-':
          _output = (firstValue - secondValue).toString();
          break;
        case 'x':
          _output = (firstValue * secondValue).toString();
          break;
        case '%':
          if (secondNumber == null) {
            _output = (firstValue / 100).toString();
          } else {
            _output = (firstValue % secondValue).toString();
          }
          break;
        case '/':
          if (secondValue == 0) {
            return;
          }
          _output = (firstValue / secondValue).toString();
          break;
      }

      firstNumber = _output;
      operator = null;
      secondNumber = null;
    });
  }

// this function is responsible for displaying text on ValueDisplay widget (appending operators, numbers, etc)
  String _getDisplayText() {
    String toReturn = '0';

    if (_output != null) {
      toReturn = '$_output';
    } else if (secondNumber != null) {
      toReturn = '$firstNumber$operator$secondNumber';
    } else if (operator != null) {
      toReturn = '$firstNumber$operator';
    } else if (firstNumber != null) {
      toReturn = '$firstNumber';
    }

    return toReturn;
  }

// This function is responsible to check length and not let number to extend certain length (length of 6)
  bool checkLength(String number) {
    bool toReturn = false;

    if (number.length < 16) {
      toReturn = true;
    }

    return toReturn;
  }

// This function is responsible for clearing values on "AC" button
  clear() {
    setState(() {
      _output = null;
      operator = null;
      secondNumber = null;
      firstNumber = null;
    });
  }

// This function is responsible for returning a single instance of button which accepts parameters for properties of button
  CalculatorButtons getCalculatorButton(
      String label,
      Function functionToCall,
      Color backgroundColor,
      Color textColor,
      double widthSize,
      double heightSize) {
    return CalculatorButtons(
      label: label,
      onTap: functionToCall,
      widthSize: widthSize,
      heightSize: heightSize,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }
}
