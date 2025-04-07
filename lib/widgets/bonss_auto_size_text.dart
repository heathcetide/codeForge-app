import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomAutoSizeText extends StatelessWidget {
  final String text;

  const CustomAutoSizeText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text, style: TextStyle(fontSize: 20), maxLines: 2);
  }
}
