import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';
import 'package:themanager/features/auth/controllers/auth_controller.dart';

class OtpPage extends ConsumerWidget {
  final String smsCodeId;
  final String phone;

  verifyOtp(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtp(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  const OtpPage({super.key, required this.smsCodeId, required this.phone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeightSpacer(hieght: AppConsts.KHeight * 0.12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                'assets/images/todo.png',
                width: AppConsts.KWidth * 0.5,
              ),
            ),
            const HeightSpacer(hieght: 26),
            ReuseableText(
                text: 'Enter your otp code',
                style: appstyle(18, AppConsts.kLight, FontWeight.bold)),
            HeightSpacer(hieght: 26),
            Pinput(
              length: 6,
              showCursor: true,
              onCompleted: (value) {
                if (value.length == 6) {
                  return verifyOtp(context, ref, value);
                }
              },
              onSubmitted: (value) {
                if (value.length == 6) {
                  return verifyOtp(context, ref, value);

                }
              },
            )
          ],
        ),
      )),
    );
  }
}
