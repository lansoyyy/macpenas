import 'package:flutter/material.dart';

class TextRegular extends StatelessWidget {
  late String text;
  late double fontSize;
  late Color color;

  TextRegular({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontSize, color: color, fontFamily: 'QRegular'),
    );
  }
}

class TextBold extends StatelessWidget {
  late String text;
  late double fontSize;
  late Color color;

  TextBold({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'QBold',
          fontWeight: FontWeight.w900),
    );
  }
}
