import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lala_awinty/controllers/auth_controller.dart';
import 'package:lala_awinty/controllers/recommandation_controller.dart';
import 'constants/firebase.dart';
import 'constants/theme.dart';
import 'core/firebase_init.dart';
import 'screens/introduction_screen.dart';
import 'widgets/loading_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AuthController());
  });
  Get.put(RecommandationsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Lala awnity app',
        theme: appTheme(context),
        home: Scaffold(
          body: Center(
            child: LoadingWidget(),
          ),
        ));
  }
}
