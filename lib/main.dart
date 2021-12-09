import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lala_awinty/controllers/auth_controller.dart';
import 'constants/firebase.dart';
import 'constants/theme.dart';
import 'core/firebase_init.dart';
import 'screens/introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: appTheme(context),
        home: FireBaseInitializationWidget(
          loggedInScreen: const Center(
            child: Text('logged in'),
          ),
          loggedOutScreen: IntroScreen(),
        ));
  }
}
