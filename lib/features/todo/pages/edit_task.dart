import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/models/task_model.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/custom_otn_btn.dart';
import 'package:themanager/common/widgets/custom_text_field.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:themanager/features/todo/controllers/dates/dates_provider.dart';

import '../controllers/todo/todo_provider.dart';

class UpdateTask extends ConsumerStatefulWidget {
  final int id;
  const UpdateTask({super.key,required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends ConsumerState<UpdateTask> {
  final TextEditingController title = TextEditingController(text: titles);
  final TextEditingController desc = TextEditingController(text: descs);

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var finish = ref.watch(finishTimeStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HeightSpacer(hieght: 20),
            CustomTextField(
                hinttext: "Add Title",
                hintStyle: appstyle(16, AppConsts.kGreyLight, FontWeight.w600),
                controller: title),
            const HeightSpacer(hieght: 20),
            CustomTextField(
                hinttext: "Add Description",
                hintStyle: appstyle(16, AppConsts.kGreyLight, FontWeight.w600),
                controller: desc),
            const HeightSpacer(hieght: 20),
            CustomOtnBen(
                onTap: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 7, 24),
                      maxTime: DateTime(2024, 12, 30),
                      theme: picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppConsts.kGreen, fontSize: 16)),
                      onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString());
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                height: 52.h,
                width: AppConsts.KWidth,
                color: AppConsts.kLight,
                color2: AppConsts.kBlueLight,
                text: scheduleDate == ''
                    ? 'Set Date'
                    : scheduleDate.substring(0, 10)),
            const HeightSpacer(hieght: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtnBen(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    height: 52.h,
                    width: AppConsts.KWidth * 0.4,
                    color: AppConsts.kLight,
                    color2: AppConsts.kBlueLight,
                    text: start == '' ? "Start Time" : start.substring(10, 16)),
                CustomOtnBen(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    height: 52.h,
                    width: AppConsts.KWidth * 0.4,
                    color: AppConsts.kLight,
                    color2: AppConsts.kBlueLight,
                    text: finish == '' ? 'End Time' : finish.substring(10, 16)),
              ],
            ),
            const HeightSpacer(hieght: 20),
            CustomOtnBen(
                onTap: () {
                  if (title.text.isNotEmpty &&
                      desc.text.isNotEmpty &&
                      scheduleDate.isNotEmpty &&
                      start.isNotEmpty &&
                      finish.isNotEmpty) {
                    Task task = Task(
                        title: title.text,
                        desc: desc.text,
                        isCompleted: 0,
                        date: scheduleDate,
                        startTime: start.substring(10, 16),
                        endTime: finish.substring(10, 16),
                        remind: 0,
                        repeat: "yes");
                    ref.read(todoStateProvider.notifier).UpdateItem(widget.id,title.text,desc.text,0,scheduleDate,start.substring(10,16),finish.substring(10,16));
                    ref.read(startTimeStateProvider.notifier).setStart('');
                    ref.read(finishTimeStateProvider.notifier).setStart('');
                    ref.read(dateStateProvider.notifier).setDate('');

                    Navigator.pop(context);
                  } else {
                  }
                },
                height: 52.h,
                width: AppConsts.KWidth,
                color: AppConsts.kLight,
                color2: AppConsts.kGreen,
                text: 'Submit'),
          
          ],
        ),
      ),
    );
  }
}
