import 'package:flutter/material.dart';

class ReuseableText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ReuseableText({Key? key, required this.text,required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      textAlign: TextAlign.left,
      softWrap: false,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}
