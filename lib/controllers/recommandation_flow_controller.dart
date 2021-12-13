import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' show PageController;
import 'package:get/get.dart';

class RecommandationFlowController extends GetxController {
  static RecommandationFlowController instance = Get.find();

  Rx<double> progress = (Get.width / 2).obs;

  Rx<PageController> pageController = PageController().obs;

  goToNextPage() {
    progress.value = Get.width;
    pageController.value
        .nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  bool goToBackPage() {
    if (progress.value == Get.width) {
      progress.value = (progress.value) / 2;
      pageController.value.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      return true;
    } else {
      // Get.back();
      return false;
    }
  }


}
