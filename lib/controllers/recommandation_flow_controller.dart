import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' show PageController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/colors.dart';

class RecommandationFlowController extends GetxController {
  static RecommandationFlowController instance = Get.find();

  Rx<double> progress = (Get.width / 3).obs;

  Rx<PageController> pageController = PageController().obs;

  Rx<PageController> pageControllerSuggestion = PageController().obs;

  RxBool isSelected = false.obs;

  Rx<Color> colorNextButtom = Colors.grey.obs;

  RxString mealIdEaten = ''.obs;

  goToNextPage() {
    progress.value += progress.value;
    pageController.value.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  bool goToBackPage() {
    if (progress.value == Get.width || progress.value == Get.width / 1.5) {
      progress.value = Get.width - (progress.value) / 3;
      pageController.value.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      return true;
    } else {
      // Get.back();
      return false;
    }
  }

  //Function to go to next probable already eaten food :
  goToNextSuggestion() {
    pageControllerSuggestion.value.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  //togle selection in suggestion page :
  toggleSelectedMeal() {
    isSelected.value = !isSelected.value;
    if (isSelected.value == true) {
      colorNextButtom.value = Colors.green;
      pageControllerSuggestion.value.keepPage;
    } else {
      colorNextButtom.value = Colors.grey;
    }
    update();
  }
}
