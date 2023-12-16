import 'package:flutter/material.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';

import 'appstyle.dart';

class CustomOtnBen extends StatelessWidget {
  final void Function()? onTap;
  final double height;
  final double width;
  final Color? color2;
  final Color color;
  final String text;

  const CustomOtnBen(
      {Key? key,
       this.onTap,
      required this.height,
      required this.width,
       this.color2,
      required this.color,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: color2,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(width: 1, color: color)),
          child: Center(
            child: ReuseableText(
                text: text, style: appstyle(18, color, FontWeight.bold)),
          ),
        ));
  }
}
