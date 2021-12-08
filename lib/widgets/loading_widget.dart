import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lala_awinty/constants/colors.dart';

// ignore: must_be_immutable
class LoadingWidget extends StatelessWidget {
  Color? color;
  LoadingWidget({this.color});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator(
            color: color ?? primaryColor,
          );
  }
}
