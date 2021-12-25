import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/screens/recommandation_flow_screen/eaten_select_page.dart';

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget(
      {required this.imageLink, required this.timeTomake, required this.title});

  final String imageLink;
  final String title;
  final String timeTomake;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .9,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: Get.height * .3,
        ),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //margin: EdgeInsets.all(5),
            width: 500,
            height: 700,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
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
          );
        },
        //scrollDirection: Axis.horizontal
      ),
    );
  }
}
