import 'package:flutter/material.dart';

class Customext extends StatelessWidget {
  final String text;

  const Customext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400, color: Color(0XFF000000)),
    );
  }
}
