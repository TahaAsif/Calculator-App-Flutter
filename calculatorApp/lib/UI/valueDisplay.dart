import 'package:flutter/material.dart';

class ValueDisplay extends StatelessWidget {
  ValueDisplay({@required this.text, this.backgroundColor, this.textColor});

  final int result = 0;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        color: backgroundColor,
        child: Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.only(right:24),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 94),
          ),
        ));
  }
}
