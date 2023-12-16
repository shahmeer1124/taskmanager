import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';
import 'package:themanager/common/widgets/custom_otn_btn.dart';
import 'package:themanager/common/widgets/custom_text_field.dart';
import 'package:themanager/common/widgets/heightSpacer.dart';
import 'package:themanager/common/widgets/reuseabletext.dart';
import 'package:themanager/common/widgets/show_dialogue.dart';

import '../controllers/auth_controller.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool clicked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController controller = TextEditingController();
  Country country = Country(
      phoneCode: '86',
      countryCode: 'CN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'China',
      example: 'China',
      displayName: 'China',
      displayNameNoCountryCode: 'CN',
      e164Key: '');

  sendCodetoUser() {
    if (controller.text.isEmpty) {
      clicked = false;
      return showAlertDialogue(
          context: context, message: 'Please Enter your phoene number');
    } else if (controller.text.length < 8) {
      clicked = false;

      return showAlertDialogue(
          context: context, message: 'Your phone number is too short');
    } else {
      ref.read(authControllerProvider).sendSms(
          context: context,
          phonenumber: '+${country.phoneCode}${controller.text}');

      clicked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Image.asset(
                'assets/images/todo.png',
                width: 300,
              ),
            ),
            HeightSpacer(hieght: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.w),
              child: ReuseableText(
                  text: "Please enter your phone number!",
                  style: appstyle(17, AppConsts.kLight, FontWeight.w500)),
            ),
            HeightSpacer(hieght: 20),
            Center(
              child: CustomTextField(
                  hinttext: 'Enter phone number',
                  hintStyle: appstyle(16, AppConsts.kBkDark, FontWeight.w600),
                  keyboardType: TextInputType.number,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                                // backgroundColor: AppConsts.kBkDark,
                                bottomSheetHeight: AppConsts.KHeight * 0.6,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppConsts.KRadius),
                                  topRight: Radius.circular(AppConsts.KRadius),
                                )),
                            onSelect: (code) {
                              setState(() {
                                country = code;
                              });
                            });
                      },
                      child: ReuseableText(
                          text: '${country.flagEmoji}${country.phoneCode}',
                          style:
                              appstyle(18, AppConsts.kBkDark, FontWeight.bold)),
                    ),
                  ),
                  controller: controller),
            ),
            HeightSpacer(hieght: 20),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOtnBen(
                    onTap: () {
                      sendCodetoUser();
                      clicked = true;
                    },
                    height: AppConsts.KHeight * 0.07,
                    width: AppConsts.KWidth * 0.9,
                    color: AppConsts.kBkDark,
                    color2: AppConsts.kLight,
                    text: "Send Code")),
            Visibility(
                visible: clicked,
                child: Center(
                    child: Text(
                  "Please Wait...",
                  style: appstyle(19, Colors.white, FontWeight.bold),
                )))
          ],
        ),
      )),
    );
  }
}
