import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/models/meal.dart';
import 'package:lala_awinty/screens/recommandation_flow_screen/widgets/SuggestionWidget.dart';
import 'package:lala_awinty/widgets/loading_widget.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

class SelectEatenMealPage extends StatelessWidget {
  SelectEatenMealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MealModel>>(
        future: mealController.getListOfMeals(),
        builder: (context, AsyncSnapshot<List<MealModel>> snapshot) {
          if (snapshot.hasData) {
            log('data size in meals ${snapshot.data!.length.toString()}');
            return Column(
              children: [
                SizedBox(
                  height: Get.height * .1,
                ),
                Text(
                  'Qu\'as-tu mangé hier soir ?',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: Get.width * .055),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
                Expanded(
                    child: PageView(
                  controller: recommandationFlowController
                      .pageControllerSuggestion.value,
                  children: snapshot.data!.map((MealModel meal) {
                    return SuggestionWidget(
                      title: meal.title!,
                      imageLink: meal.photoURL!,
                      timeTomake: meal.timeToMake!,
                      // subtitle: Text(document.title!),
                    );
                  }).toList(),
                )),
                Text(
                  'Aucune de ces récommendations',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                AppPrimaryButton(
                  onPressed: null,
                  text: 'Suivant',
                  width: 300,
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          return Center(
            child: LoadingWidget(),
          );
        });
  }
}

String testImg =
    "https://firebasestorage.googleapis.com/v0/b/lalaawinty.appspot.com/o/lunch_20_30%2FWhatsApp%20Image%202021-11-30%20at%2011.51.10%20PM(1).jpeg?alt=media&token=87819f47-9307-4dbd-a6e1-e1db0ef14e0e";
