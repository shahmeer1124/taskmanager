
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HeightSpacer extends StatelessWidget {
  final double hieght;
  const HeightSpacer({
    Key? key,required this.hieght
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght.h,
    );
  }
}

class WidthSpacer extends StatelessWidget {
  final double width;
  const WidthSpacer({
    Key? key,required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
    );
  }
}
