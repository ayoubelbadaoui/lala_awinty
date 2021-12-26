import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';

class AppPrimaryButton extends StatelessWidget {
  AppPrimaryButton(
      {this.onPressed,
      required this.text,
      this.width,
      this.isActive,
      this.color});

  VoidCallback? onPressed;
  final String text;
  double? width;
  bool? isActive;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * .5,
      height: 45,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: color ?? primaryColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          )),
    );
  }
}
