import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, required this.payload});
  final String payload;

  @override
  Widget build(BuildContext context) {
    var title = payload.split('|')[0];
    var desc = payload.split('|')[1];
    var  date= payload.split('|')[2];
    var start = payload.split('|')[3];
    var end = payload.split('|')[4];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Container(
              width: AppConsts.KWidth,
              height: AppConsts.KHeight * 0.7,
              decoration: BoxDecoration(
                  color: AppConsts.kBKlight,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppConsts.KRadius))),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReuseableText(
                        text: 'Remainder',
                        style: appstyle(40, AppConsts.kLight, FontWeight.bold)),
                    HeightSpacer(hieght: 5),
                    Container(
                      width: AppConsts.KWidth,
                      padding: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color: AppConsts.kYellow,
                          borderRadius: BorderRadius.all(Radius.circular(9.h))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReuseableText(
                              text: "Today",
                              style: appstyle(
                                  14, AppConsts.kBkDark, FontWeight.bold)),
                          WidthSpacer(width: 15),
                          ReuseableText(
                              text: "From : $start To $end",
                              style: appstyle(
                                  15, AppConsts.kBkDark, FontWeight.w600)),
                        ],
                      ),
                    ),
                    HeightSpacer(hieght: 10),
                    ReuseableText(
                        text: title,
                        style:
                            appstyle(30, AppConsts.kBkDark, FontWeight.bold)),
                    HeightSpacer(hieght: 10),
                    Text(desc,
                        maxLines: 8,
                        textAlign: TextAlign.justify,
                        style: appstyle(16, AppConsts.kLight, FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 12.w,
              top: -10,
              child: Image.asset(
                'assets/images/bell.png',
                width: 70.w,
                height: 70.h,
              )),
          Positioned(
              right: 0,
              bottom: -AppConsts.KHeight * 0.142,
              left: 0,
              child: Image.asset(
                'assets/images/notification.png',
                width: AppConsts.KWidth * 0.8,
                height: AppConsts.KHeight * 0.6,
              ))
        ],
      )),
    );
  }
}
