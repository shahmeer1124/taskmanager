import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';

showAlertDialogue(
    {required BuildContext context,
    required String message,
    String? buttontext}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(buttontext??"Ok",style: appstyle(18, AppConsts.kGreyLight, FontWeight.w500),))
          ],
          content: ReuseableText(
              text: message,
              style: appstyle(18, AppConsts.kLight, FontWeight.w600)),
        );
      });
}
