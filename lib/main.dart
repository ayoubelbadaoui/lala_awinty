import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/controllers/auth_controller.dart';
import 'package:lala_awinty/controllers/recommandation_controller.dart';
import 'constants/firebase.dart';
import 'constants/theme.dart';
import 'controllers/meal_controller.dart';
import 'controllers/recommandation_flow_controller.dart';
import 'widgets/loading_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AuthController());
  });
  Get.put(RecommandationsController());
  Get.put(RecommandationFlowController());
  Get.put(MealController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lala awnity app',
        theme: appTheme(context),
        home: Scaffold(
          body: Center(
            child: LoadingWidget(),
          ),
        ));
  }
}
