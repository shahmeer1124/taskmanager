import 'package:flutter/material.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/widgets/custom_otn_btn.dart';
import '../../../common/widgets/heightSpacer.dart';
import '../../auth/pages/login_page.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

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
          const HeightSpacer(hieght: 50),
          CustomOtnBen(
              onTap: () {
                Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) =>LoginPage()));
              },
              height: AppConsts.KHeight * 0.06,
              width: AppConsts.KWidth * 0.9,
              color: AppConsts.kLight,
              text: 'Login with a phone number!')
        ],
      ),
    );
  }
}
