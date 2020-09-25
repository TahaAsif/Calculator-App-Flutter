import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {
  CalculatorButtons(
      {@required this.label,
      @required this.onTap,
      @required this.widthSize,
      @required this.heightSize,
      this.backgroundColor = Colors.white,
      this.labelColor = Colors.black});

  final String label;
  final VoidCallback onTap;
  final double widthSize;
  final double heightSize;
  final Color backgroundColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        width: widthSize,
        height: heightSize,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
        ], borderRadius: BorderRadius.all(Radius.circular(heightSize / 2)),
        color: backgroundColor,
        ),
        child: FlatButton(
          shape: CircleBorder(),
          onPressed: onTap,
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 24, color: labelColor),

            ),
          ),
        ),
      ),
    );
  }
}
