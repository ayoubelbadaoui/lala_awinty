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
import 'package:lala_awinty/widgets/loading_widget.dart';
import 'package:lala_awinty/widgets/primary_button.dart';
import 'package:lala_awinty/widgets/secondary_button.dart';


final _formKey = GlobalKey<FormState>();


MealMDL _meal = MealMDL();

class EditMealUI extends StatelessWidget {

  final String idMeal;

  EditMealUI({required this.idMeal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier une repas'),
      ),
        body: FutureBuilder<MealMDL>(
          future: mealController.getMealWithID(idMeal),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return const Center(
                child: Text('No internet'),
              );
            }
            if (snapshot.hasData && snapshot.data == null) {
              return const Center(child: Text("vous avez pas ajouté des recommendatioms"));
            }
            if (snapshot.connectionState == ConnectionState.done){

              MealMDL? _mealData = snapshot.data;

              return SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  //reverse: true,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        FractionallySizedBox(
                          widthFactor: .9,
                          child: AppInput(
                              //controller: mealController.mealTitle,
                              hint: 'Titre de repas',
                              validator: (String? titleMeal) {
                                if (titleMeal!.isEmpty) {
                                  return 'Merci d\'écrire titre de repas';
                                }
                                _meal.title = titleMeal;
                              },
                            initialValue: _mealData!.title,
                              ),
                        ),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        FractionallySizedBox(
                          widthFactor: .9,
                          child: AppInput(
                              initialValue: _mealData.timeToMake,
                             // controller: mealController.mealTime,
                              textInputType: TextInputType.number,
                              hint: 'estimation pour la repas en Min',
                              validator: (String? mealTime) {
                                if (mealTime!.isEmpty) {
                                  return 'Merci d\'écrire temps estimé pour le repas';
                                }
                                _meal.timeToMake = mealTime;
                              }),
                        ),

                        SizedBox(
                          height: Get.height * .03,
                        ),
                        FractionallySizedBox(
                          widthFactor: .9,
                          child: AppInput(
                              initialValue: _mealData.youtubeLink,
                             // controller: mealController.mealVideUrl,
                              textInputType: TextInputType.number,
                              hint: 'Lien de youtube pour la repas',
                              validator: (String? youtubeLink) {
                                if (youtubeLink!.isEmpty) {
                                  return 'Merci d\'écrire lien de youtube pour la repas';
                                }
                                else  if (!youtubeLink.isURL) {
                                  return 'Merci d\'écrire un lien valid \'https://..\'';
                                }
                                _meal.youtubeLink = youtubeLink;
                              }),
                        ),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        FractionallySizedBox(
                          widthFactor: .9,
                          child: AppInput(
                            initialValue: _mealData.description,
                              //controller: mealController.mealDesc,
                              textInputType: TextInputType.number,
                              height:6,
                              hint: 'Description',
                              validator: (String? description) {
                                if (description!.isEmpty) {
                                  return 'Merci d\'écrire la description de la repas';
                                }
                                _meal.description = description;
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
                            storeValueOnChange: 'budget_meal',
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
                            storeValueOnChange: 'type_meal',
                            value: _mealData.mealType,
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
                                    ? DecorationImage(
                                      image: NetworkImage(
                                      _mealData.photoURL!,
                                    ),
                                    fit: BoxFit.cover)
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
                                  await mealController.editMeal(idMeal,MealMDL(
                                      title: _meal.title,
                                      priceRange:mealController.budgetMeal,
                                      timeToMake:_meal.timeToMake,
                                      mealType: mealController.typeMeal,
                                      youtubeLink: _meal.youtubeLink,
                                      description: _meal.description,
                                     // photoURL: _mealData.photoURL,
                                      at: _mealData.at
                                  ));
                                  Navigator.pop(context);
                                }
                              },
                              text: 'Modifier le repas'),
                        ),
                        SizedBox(
                          height: Get.height * .07,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
           return Center(child: LoadingWidget());
          },
        )
    );
  }
}
