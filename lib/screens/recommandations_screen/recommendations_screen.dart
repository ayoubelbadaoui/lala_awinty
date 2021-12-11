import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/screens/recommandations_screen/tabs/launch_screen.dart';

import 'tabs/dinner_screen.dart';

class RecommendationsScreen extends StatelessWidget {

  const RecommendationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarDemo();
  }
}


class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: Get.height * .18,
            backgroundColor: primaryColor,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Text('Déjeuner')),
                Tab(icon: Text('Dîner'))
              ],
            ),
            actions: [
              Expanded(
                child:  FractionallySizedBox(
                    widthFactor: .8,
                    heightFactor: 1,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * .09,),
                          Container(
                              child: Text(
                                  'Les plats recommandé par LALA Awinty',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  fontSize: Get.width * .05
                                ),
                              ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              LaunchScreen(),
              DinnerScreen()
            ],
          ),
        ),
      ),
    );
  }
}
