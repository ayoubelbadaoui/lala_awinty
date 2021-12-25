import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/widgets/app_selector_options.dart';
import 'package:lala_awinty/widgets/custom_text.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

class MealBudgetPage extends StatelessWidget {
  const MealBudgetPage({Key? key}) : super(key: key);

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
                const Customext(
                  text: 'Choisir votre budget',
                ),
                AppSelectorOption(
                  items: <String>['20-30', '30-50', '50-70', '50-100'],
                  onChange: (value) {
                    recommandationsController.priceRange.value = value;
                  },
                ),
                SizedBox(
                  height: Get.height * .05,
                ),
                const Customext(
                  text: 'Choisir type de repas',
                ),
                AppSelectorOption(
                  items: <String>['Déjeuner', 'Dîner'],
                  onChange: (value) {
                    recommandationsController.mealType.value = value;
                  },
                ),
                SizedBox(
                  height: Get.height * .07,
                ),
                Center(
                    child: AppPrimaryButton(
                        onPressed: () {
                          recommandationFlowController.goToNextPage();
                        },
                        text: 'Suivant'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
