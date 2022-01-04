import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/models/meal.dart';
import 'package:lala_awinty/models/recommandation.dart';

class RecommandationsController extends GetxController {
  static RecommandationsController instance = Get.find();

  RxString mealType = 'Déjeuner'.obs;
  RxString priceRange = '20-30'.obs;

  RecommandationMDL recommandationMDL = RecommandationMDL();

  Stream<List<MealMDL>> getStreamOfLaunchRecommandations() {
    print('price range :${priceRange.value}');

    return MealMDL()
        .mealRef
        .where('typeMeal', isEqualTo: 'Déjeuner')
        .where('priceRange', isEqualTo: priceRange.value)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<MealMDL> _recommandations = [];
      for (var element in querySnapshot.docs) {
        _recommandations.add(MealMDL.fromDocumentSnapshot(element));
      }
      return _recommandations;
    });
  }

  Stream<List<MealMDL>> getStreamOfDinnerRecommandations() {
    return MealMDL()
        .mealRef
        .where('typeMeal', isEqualTo: 'Dîner')
        .where('priceRange', isEqualTo: priceRange.value)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<MealMDL> _recommandations = [];
      for (var element in querySnapshot.docs) {
        _recommandations.add(MealMDL.fromDocumentSnapshot(element));
      }
      return _recommandations;
    });
  }
}
