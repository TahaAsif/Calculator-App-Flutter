import 'package:calculatorApp/UI/calculatorDisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyCalculatorApp());
}

class MyCalculatorApp extends StatefulWidget {
  @override
  _MyCalculatorAppState createState() => _MyCalculatorAppState();
}


class _MyCalculatorAppState extends State<MyCalculatorApp> {


@override
void initState()
{
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    )
  );

  super.initState();
}

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        body: CalculatorDisplay(),
    ));
  }
}