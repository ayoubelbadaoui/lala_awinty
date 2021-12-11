import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/widgets/app_input.dart';
import 'package:lala_awinty/widgets/app_selector_options.dart';
import 'package:lala_awinty/widgets/custom_text.dart';

class RecommandationFollowScreen extends StatelessWidget {
  const RecommandationFollowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: FractionallySizedBox(
          widthFactor: .75,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .34,
                ),
                Customext(
                  text: 'Choisir votre budget',
                ),
                AppSelectorOption(),
                SizedBox(
                  height: Get.height * .05,
                ),
                Customext(
                  text: 'Choisir type de repas',
                ),
                AppSelectorOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
