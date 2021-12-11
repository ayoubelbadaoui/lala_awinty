import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/models/recommandation.dart';
import 'package:lala_awinty/screens/recommandation_flow_screen/recommandation_flow_screen.dart';
import 'package:lala_awinty/widgets/loading_widget.dart';

class DinnerScreen extends StatelessWidget {
  const DinnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<RecommandationMDL>>(
        stream: recommandationsController.getStreamOfDinnerRecommandations(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RecommandationMDL>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: LoadingWidget());
          }
          if (snapshot.data!.isEmpty) {
            return  Center(
              child: FractionallySizedBox(
                  widthFactor: .6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Vous n\'avez pas encore de recommandation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Get.width * .05
                        ),
                      ),
                      const Text('ajouter une nouvelle recommandation en cliquant sur le bouton ci-dessous')
                    ],
                  )
              ),
            );
          }
          return const Center(
            child: Text('u have some'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child:const Icon(Icons.add),
          onPressed: (){
            Get.to(const RecommandationFollowScreen());
          }
      ),
    );
  }
}
