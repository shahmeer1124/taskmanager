import 'package:flutter/material.dart';
import 'package:themanager/common/utils/constants.dart';
import 'package:themanager/common/widgets/appstyle.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? hinttext;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const CustomTextField(
      {super.key,
      this.keyboardType,
      required this.hinttext,
      this.suffixIcon,
      this.prefixIcon,
      this.hintStyle,
      required this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConsts.KWidth * 0.9,
      // height: AppConsts.KHeight * 0.07,
      decoration: BoxDecoration(
          color: AppConsts.kLight,
          borderRadius: BorderRadius.all(Radius.circular(AppConsts.KRadius))),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 25,
        onChanged: onChanged,
        style: appstyle(18, AppConsts.kBkDark, FontWeight.w700),
        decoration: InputDecoration(
            hintText: hinttext,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            suffixIconColor: AppConsts.kBkDark,
            hintStyle: hintStyle,
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: AppConsts.kRed, width: 0.5)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0.5)),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: AppConsts.kRed, width: 0.5)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: AppConsts.kGreyDark, width: 0.5)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: AppConsts.kBkDark, width: 0.5))),
      ),
    );
  }
}
