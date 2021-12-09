import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPrimaryButton extends StatelessWidget {

   AppPrimaryButton({required this.onPressed,required this.text,this.width});

  final onPressed;
  final String text;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * .5,
      height: 45,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
          )
      ),
    );
  }
}
