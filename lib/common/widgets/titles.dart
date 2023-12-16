import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';
import 'package:themanager/features/todo/controllers/todo/todo_provider.dart';

class BottomTitle extends StatelessWidget {
  final String text;
  final String text2;
  final Color? color;
  const BottomTitle(
      {super.key, required this.text, required this.text2, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConsts.KWidth,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(builder: (context, ref, child) {
              Color color = AppConsts.kGreen;
              // ref.read(todoStateProvider.notifier).getRandomColor();
              return Container(
                height: 80,
                width: 5,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConsts.KRadius))),
              );
            }),
            const WidthSpacer(width: 15),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                      text: text,
                      style: appstyle(24, AppConsts.kLight, FontWeight.bold)),
                  HeightSpacer(hieght: 10),
                  ReuseableText(
                      text: text2,
                      style: appstyle(12, AppConsts.kLight, FontWeight.normal)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
