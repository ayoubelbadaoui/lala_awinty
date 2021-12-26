import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/screens/recommandation_flow_screen/budget_type_meal_screen.dart';
import 'package:lala_awinty/screens/recommandation_flow_screen/eaten_select_page.dart';
import 'package:lala_awinty/screens/recommandations_screen/tabs/ready_screen.dart';
import 'package:lala_awinty/widgets/app_input.dart';
import 'package:lala_awinty/widgets/app_selector_options.dart';
import 'package:lala_awinty/widgets/custom_text.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

class RecommandationFollowScreen extends StatelessWidget {
  const RecommandationFollowScreen({Key? key}) : super(key: key);

  Future<bool> _onWillPop() async {
    if (!recommandationFlowController.goToBackPage()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                width: recommandationFlowController.progress.value,
                duration: Duration(milliseconds: 500),
                height: 10,
                color: primaryColor,
              ),
              Expanded(
                child: PageView(
                  controller: recommandationFlowController.pageController.value,
                  children: <Widget>[
                    MealBudgetPage(),
                    SelectEatenMealPage(),
                    ReadyMealRecommandationScreen()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
