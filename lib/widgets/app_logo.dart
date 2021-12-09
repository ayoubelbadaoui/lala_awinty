import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLogo extends StatelessWidget {

  AppLogo({this.width});

  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * .4,
      child: Image.asset(
          'assets/logo.png',
      ),
    );
  }
}
