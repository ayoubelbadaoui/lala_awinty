import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/screens/home_screen/home_screen.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

import '../recommendations_screen.dart';

class ReadyMealRecommandationScreen extends StatelessWidget {
  const ReadyMealRecommandationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: Get.width,
      child: FractionallySizedBox(
        widthFactor: .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .1,
              ),
              Text(
                'Super ,allons maintenant découvrir d\'autres recettes',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: primaryColor, fontSize: Get.width * .058),
              ),
              SizedBox(
                height: Get.height * .04,
              ),
              Image.asset('assets/ready.png'),
              SizedBox(
                height: Get.height * .04,
              ),
              Image.asset('assets/ok.png'),
              SizedBox(
                height: Get.height * .05,
              ),
              AppPrimaryButton(
                  text: 'Découvrie des autres recettes',
                  width: Get.width * .8,
                  onPressed: () async {
                    Get.offAll(HomeScreen());
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
