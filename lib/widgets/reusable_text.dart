import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
      {super.key, required this.text, required this.style, this.maxLines = 2});

  final String text;
  final TextStyle style;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      softWrap: false,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
