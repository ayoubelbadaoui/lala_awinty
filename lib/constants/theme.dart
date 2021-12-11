import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData appTheme(BuildContext context) => ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(
    Theme.of(context).textTheme,
  ).copyWith(
    bodyText1: TextStyle(
      fontSize: Get.width * .04,
      color: Colors.white,
      fontWeight: FontWeight.w400
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)),),
      elevation: MaterialStateProperty.all(0)
    ),
  ),
);