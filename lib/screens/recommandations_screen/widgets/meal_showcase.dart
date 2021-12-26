import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealShowCase extends StatelessWidget {
  const MealShowCase({Key? key,required this.rating,required this.timeTomake,required this.imageUrl,required this.title,required this.priceRange}) : super(key: key);

  final String timeTomake;
  final String imageUrl;
  final String title;
  final String priceRange;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Get.height * .013),
        width: Get.width * .9,
        height: Get.height * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.greenAccent,
        ),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: Get.width,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.all(4),
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xffFAFCFA)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Icon(Icons.timer,size: 18,), Text('$timeTomake min')],
                        ),
                      ))
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Colors.amber,
                      image: DecorationImage(
                        image: NetworkImage(
                          imageUrl
                        ),
                        fit: BoxFit.cover
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color: Colors.black.withOpacity(.25))
                      ]),
                )),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Color(0xffFCFEFC),
              ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                                title,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: Get.width * .045
                              ),
                            ),
                            Text(priceRange)
                          ],
                        ),
                        Text(rating)
                      ],
                    ),
                  ),
            )),
          ],
        ),
      ),
    );
  }
}
