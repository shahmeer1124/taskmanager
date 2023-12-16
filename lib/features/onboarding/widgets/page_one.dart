import 'package:flutter/material.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConsts.KHeight,
      width: AppConsts.KWidth,
      color: AppConsts.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset('assets/images/todo.png'),
          ),
          const HeightSpacer(hieght: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReuseableText(
                  text: "Manage your Tasks",
                  style: appstyle(30, AppConsts.kLight, FontWeight.w600)),
              const HeightSpacer(hieght: 10),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: Text(
                  "Welcome!! Do you want to create a task fast and with ease?",
                  textAlign: TextAlign.center,
                  style: appstyle(16, AppConsts.kGreyLight, FontWeight.normal),
                ),
              )
            ],
          )
        ],
      ),
    );
  
  }
}
