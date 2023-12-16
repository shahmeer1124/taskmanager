import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/helper/notification_helper.dart';
import 'package:themanager/common/models/task_model.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/custom_otn_btn.dart';
import 'package:themanager/common/widgets/custom_text_field.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:themanager/common/widgets/show_dialogue.dart';
import 'package:themanager/features/todo/controllers/dates/dates_provider.dart';
import 'package:themanager/features/todo/pages/home_page.dart';
import 'package:intl/intl.dart';
import '../controllers/todo/todo_provider.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit = 'ca-app-pub-8519627525427787/1076844846';
  List<int> difference = [];

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adUnit,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        }, onAdFailedToLoad: ((ad, error) {
         
          ad.dispose();
        })),
        request: const AdRequest());
    bannerAd.load();
  }

  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  late NotificationHelper notifhelper;
  List<int> notifications = [];
  late NotificationHelper controller;
  final TextEditingController search = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  void initState() {
    // TODO: implement initState
    initBannerAd();
    notifhelper = NotificationHelper(ref: ref);
    Future.delayed(Duration(seconds: 0), () {
      controller = NotificationHelper(ref: ref);
    });
    notifhelper.initializeNotification();
    super.initState();
  }

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
                // 2023-08-10 15:07:00.000
                CustomOtnBen(
                    onTap: () {
                      picker.DatePicker.showTimePicker(context,
                          showTitleActions: true,
                          onChanged: (time) {}, onConfirm: (date) {
                       notifications = ref
                            .read(startTimeStateProvider.notifier)
                            .dates(date);
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
                      picker.DatePicker.showTimePicker(context,
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
                        startTime:  start.substring(10, 16),
                        endTime: finish.substring(10,16),
                        remind: 0,
                        repeat: "yes");
                    notifhelper.scheduleNotification(
                      notifications[0],
                      notifications[1],
                      notifications[2],
                      notifications[3],
                      task,
                    );
                    ref.read(todoStateProvider.notifier).addItem(task);
                    ref.read(startTimeStateProvider.notifier).setStart('');
                    ref.read(finishTimeStateProvider.notifier).setStart('');
                    ref.read(dateStateProvider.notifier).setDate('');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  } else {
                    showAlertDialogue(
                        context: context, message: "Failed to add task");
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
      bottomNavigationBar: isAdLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : SizedBox(),
    );
  }
}
