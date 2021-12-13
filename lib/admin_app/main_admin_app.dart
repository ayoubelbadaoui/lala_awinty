import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/helpers/showLoading.dart';
import 'package:lala_awinty/models/meal.dart';
import 'package:lala_awinty/widgets/app_input.dart';
import 'package:lala_awinty/widgets/app_selector_options.dart';
import 'package:lala_awinty/widgets/custom_text.dart';
import 'package:lala_awinty/widgets/primary_button.dart';
import 'package:lala_awinty/widgets/secondary_button.dart';

final _formKey = GlobalKey<FormState>();


MealModel _meal = MealModel();
class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * .1,
                  ),
                  Text(
                    'Ajouter une repas',
                    style: TextStyle(fontSize: Get.width * .05),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  FractionallySizedBox(
                    widthFactor: .9,
                    child: AppInput(
                      controller: mealController.mealTitle,
                        hint: 'Titre de repas',
                        validator: (String? titleMeal) {
                          if (titleMeal!.isEmpty) {
                            return 'Merci d\'écrire titre de repas';
                          }
                          _meal.title = titleMeal;
                        }),
                  ),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  FractionallySizedBox(
                    widthFactor: .9,
                    child: AppInput(
                      controller: mealController.mealType,
                        textInputType: TextInputType.number,
                        hint: 'estimation pour la repas en Min',
                        validator: (String? titleMeal) {
                          if (titleMeal!.isEmpty) {
                            return 'Merci d\'écrire temps estimé pour le repas';
                          }
                          _meal.timeToMake = titleMeal;
                        }),
                  ),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  const FractionallySizedBox(
                    widthFactor: .9,
                    child: Customext(
                      text: 'Budget de repas',
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: .9,
                    child: AppSelectorOption(
                      items: const <String>['20-30', '30-50', '50-70', '50-100'],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  const FractionallySizedBox(
                    widthFactor: .9,
                    child: Customext(
                      text: 'Type de repas',
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: .9,
                    child: AppSelectorOption(
                      items: const <String>['Déjeuner', 'Dîner'],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  SecondaryButton(
                      width: 300,
                      onPressed: () async => await mealController.pickImageMeal(),
                      text: 'Choisir la photo de repas'),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  Obx(
                        () => Container(
                      width: Get.width * .9,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: mealController.obsImageTho.value == ""
                                  ? primaryColor
                                  : Colors.greenAccent),
                          image: mealController.obsImageTho.value == ''
                              ? null
                              : DecorationImage(
                              image: FileImage(
                                File(mealController.obsImageTho.value),
                              ),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .07,
                  ),
                  Center(
                    child: AppPrimaryButton(
                        width: 300,
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            showLoading();
                            await mealController.addNewMeal(MealModel(
                                title: 'blyqt',
                                priceRange:'70-100',
                                timeToMake:'20 min',
                                mealType: 'Dinner'
                            ));
                            Navigator.pop(context);
                          }
                        },
                        text: 'Ajouter le repas'),
                  ),
                  SizedBox(
                    height: Get.height * .07,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
