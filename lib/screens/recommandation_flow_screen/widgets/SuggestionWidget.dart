import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/screens/recommandation_flow_screen/eaten_select_page.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class SuggestionWidget extends StatelessWidget {
  SuggestionWidget(
      {required this.imageLink,
      required this.timeTomake,
      required this.title,
      required this.idMeal,
      this.isSelected = false});

  final String imageLink;
  final String title;
  final String timeTomake;
  final String idMeal;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: .9,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Bounce(
                duration: Duration(milliseconds: 110),
                onPressed: () {
                  recommandationFlowController.toggleSelectedMeal();
                  recommandationFlowController.mealIdEaten.value =
                      recommandationFlowController.isSelected.value
                          ? idMeal
                          : '';
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Get.width / 1.6,
                      height: Get.width / 1.6,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(.5),
                          //borderRadius: BorderRadius.circular(200),
                          image: DecorationImage(
                              image: NetworkImage(imageLink), fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 30,
                                color: Colors.black.withOpacity(.25))
                          ]),
                    ),
                    Visibility(
                      visible: isSelected,
                      child: Positioned(
                        right: 10,
                        child: Icon(
                          Icons.verified,
                          color: Colors.greenAccent,
                          size: Get.width / 6,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: Get.width * .045),
              ),
              Text(
                '$timeTomake min',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
            ],
          ),
        ));
  }
}
