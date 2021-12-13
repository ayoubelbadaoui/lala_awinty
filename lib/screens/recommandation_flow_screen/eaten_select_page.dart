import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

class SelectEatenMealPage extends StatelessWidget {
  SelectEatenMealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: FractionallySizedBox(
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
                                image: NetworkImage(testImg), fit: BoxFit.fill),
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
                        'Lmakla',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: Get.width * .045),
                      ),
                      Text(
                        '30 min',
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
          ),
        ),
        Text(
          'Aucune de ces récommendations',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
}

String testImg =
    "https://firebasestorage.googleapis.com/v0/b/lalaawinty.appspot.com/o/lunch_20_30%2FWhatsApp%20Image%202021-11-30%20at%2011.51.10%20PM(1).jpeg?alt=media&token=87819f47-9307-4dbd-a6e1-e1db0ef14e0e";
