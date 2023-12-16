import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';
import '../widgets/page_one.dart';
import '../widgets/page_two.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              PageOne(),
              PageTwo(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Ionicons.chevron_forward_circle,
                          color: AppConsts.kLight,
                          size: 30,
                        ),
                        onTap: () {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.ease);
                        },
                      ),
                      const WidthSpacer(width: 5),
                      ReuseableText(
                          text: "Skip",
                          style:
                              appstyle(16, AppConsts.kLight, FontWeight.w500)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.nextPage(
                          duration:const Duration(milliseconds: 600),
                          curve: Curves.ease);
                    },
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                      effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 16,
                        spacing: 10,
                        dotColor: AppConsts.kYellow,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
