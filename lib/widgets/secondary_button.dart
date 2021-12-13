import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryButton extends StatelessWidget {

  SecondaryButton({required this.onPressed,required this.text,this.width});

  final onPressed;
  final String text;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width * .5,
      height: 45,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  )
              ),
            backgroundColor: MaterialStateProperty.all<Color>(
               Colors.white
            ),
            splashFactory: InkSplash.splashFactory
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black
            ),
          )
      ),
    );
  }
}
