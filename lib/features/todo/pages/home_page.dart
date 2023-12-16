import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/common/helper/notification_helper.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/custom_text_field.dart';
import 'package:themanager/features/todo/controllers/todo/todo_provider.dart';
import 'package:themanager/features/todo/widgets/tomorrowtask.dart';
import '../../../common/widgets/heightSpacer.dart';
import '../../../common/widgets/reuseabletext.dart';
import '../widgets/TodaysTask.dart';
import '../widgets/completedTask.dart';
import '../widgets/dayaftertomorrow.dart';
import 'add.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final TextEditingController search = TextEditingController();
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  late NotificationHelper notificationHelper;
  late NotificationHelper controller;

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit = 'ca-app-pub-8519627525427787/1076844846';

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

  @override
  void initState() {
    // TODO: implement initState
    initBannerAd();
    notificationHelper = NotificationHelper(ref: ref);
    Future.delayed(Duration(seconds: 0), () {
      controller = NotificationHelper(ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(85),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReuseableText(
                          text: "Dashboard",
                          style:
                              appstyle(18, AppConsts.kLight, FontWeight.bold)),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                            color: AppConsts.kLight,
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.add,
                            color: AppConsts.kBkDark,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTask()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const HeightSpacer(hieght: 20),
                CustomTextField(
                  hinttext: 'Search',
                  controller: search,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(14.h),
                    child: GestureDetector(
                      child: const Icon(
                        AntDesign.search1,
                        color: AppConsts.kGreyLight,
                      ),
                      onTap: () {},
                    ),
                  ),
                  suffixIcon: const Icon(
                    FontAwesome.sliders,
                    color: AppConsts.kGreyLight,
                  ),
                ),
                HeightSpacer(hieght: 15)
              ],
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              HeightSpacer(hieght: 25),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: AppConsts.kLight,
                  ),
                  const WidthSpacer(width: 10),
                  ReuseableText(
                      text: "Today's Task",
                      style: appstyle(18, AppConsts.kLight, FontWeight.bold))
                ],
              ),
              HeightSpacer(hieght: 25),
              Container(
                decoration: BoxDecoration(
                    color: AppConsts.kLight,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConsts.KRadius))),
                child: TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.zero,
                    isScrollable: false,
                    labelColor: AppConsts.kBlueLight,
                    labelStyle:
                        appstyle(24, AppConsts.kBlueLight, FontWeight.w700),
                    unselectedLabelColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppConsts.kGreyLight,
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppConsts.KRadius)),
                    ),
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: AppConsts.KWidth * 0.5,
                          child: Center(
                            child: ReuseableText(
                                text: 'Pending',
                                style: appstyle(
                                    16, AppConsts.kBkDark, FontWeight.bold)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(left: 30.w),
                          width: AppConsts.KWidth * 0.5,
                          child: Center(
                            child: ReuseableText(
                                text: 'Completed',
                                style: appstyle(
                                    16, AppConsts.kBkDark, FontWeight.bold)),
                          ),
                        ),
                      )
                    ]),
              ),
              const HeightSpacer(hieght: 20),
              SizedBox(
                height: AppConsts.KHeight * 0.3,
                width: AppConsts.KWidth,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppConsts.KRadius)),
                  child: TabBarView(controller: tabController, children: [
                    Container(
                      color: AppConsts.kBKlight,
                      height: AppConsts.KHeight * 0.3,
                      child: const TodayTask(),
                    ),
                    Container(
                      color: AppConsts.kBKlight,
                      height: AppConsts.KHeight * 0.3,
                      child: CompletedTask(),
                    )
                  ]),
                ),
              ),
              const HeightSpacer(hieght: 20),
              TomorrowList(),
              const HeightSpacer(hieght: 20),
              DayAfterTomorrowList()
            ],
          ),
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
