import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';

class TodoTile extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final String marker;
  final void Function()? delete;

  const TodoTile(
      {super.key,
      this.color,
      this.title,
      this.description,
      this.start,
      this.end,
      this.editWidget,
      this.switcher,
      required this.marker,
      this.delete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: AppConsts.KWidth,
            decoration: BoxDecoration(
              color: AppConsts.kGreyLight,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppConsts.KRadius)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                          color: color ?? AppConsts.kRed,
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppConsts.KRadius))),
                    ),
                    const WidthSpacer(width: 15),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: AppConsts.KWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableText(
                                text: title ?? 'Title of todo',
                                style: appstyle(
                                    18, AppConsts.kLight, FontWeight.bold)),
                            HeightSpacer(hieght: 3),
                            ReuseableText(
                                text: description ?? 'Description of todo',
                                style: appstyle(
                                    18, AppConsts.kLight, FontWeight.bold)),
                            HeightSpacer(hieght: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: AppConsts.KWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                      color: AppConsts.kBkDark,
                                      border: Border.all(
                                          width: 0.3,
                                          color: AppConsts.kGreyDark),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(AppConsts.KRadius))),
                                  child: Center(
                                      child: ReuseableText(
                                          text: '$start || $end',
                                          style: appstyle(12, AppConsts.kLight,
                                              FontWeight.normal))),
                                ),
                                WidthSpacer(width: 20),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editWidget,
                                    ),
                                    WidthSpacer(width: 20),
                                    GestureDetector(
                                      onTap: delete,
                                      child: const Icon(
                                          MaterialCommunityIcons.delete_circle),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 0.h,
                      ),
                      child: switcher,
                    ),
                    WidthSpacer(width: 10),
                    Text(
                      marker ,
                      style: appstyle(11, Colors.white, FontWeight.normal),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
