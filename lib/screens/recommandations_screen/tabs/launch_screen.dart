import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/models/recommandation.dart';
import 'package:lala_awinty/screens/recommandation_flow_screen/recommandation_flow_screen.dart';
import 'package:lala_awinty/screens/recommandations_screen/widgets/meal_showcase.dart';
import 'package:lala_awinty/widgets/loading_widget.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<List<RecommandationMDL>>(
          stream: recommandationsController.getStreamOfLaunchRecommandations(),
          builder: (BuildContext context,
              AsyncSnapshot<List<RecommandationMDL>> snapshot) {
            if (snapshot.hasError) {
              return  Text('Something went wrong ${snapshot.error.toString()}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LoadingWidget());
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: FractionallySizedBox(
                    widthFactor: .6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Vous n\'avez pas encore de recommandation',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Get.width * .05),
                        ),
                        const Text(
                            'ajouter une nouvelle recommandation en cliquant sur le bouton ci-dessous')
                      ],
                    )),
              );
            }
            return  ListView.builder(
                itemBuilder: (BuildContext context,int index){
                  return MealShowCase(
                    timeTomake: snapshot.data![index].timeToMake!,
                    imageUrl: snapshot.data![index].photoURL!,
                    priceRange: snapshot.data![index].priceRange!,
                    title: snapshot.data![index].title!,
                    rating: snapshot.data![index].rating!,
                  );
                },
              itemCount: snapshot.data!.length,
            );
          },
        ),
      ),
    );
  }
}
