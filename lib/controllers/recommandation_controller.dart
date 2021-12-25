import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/constants/firebase.dart';
import 'package:lala_awinty/models/recommandation.dart';
import 'package:lala_awinty/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecommandationsController extends GetxController {
  static RecommandationsController instance = Get.find();

  RxString mealType = '20-30'.obs;
  RxString priceRange = 'Déjeuner'.obs;

  RecommandationMDL recommandationMDL = RecommandationMDL();

  Stream<List<RecommandationMDL>> getStreamOfLaunchRecommandations() {
    return recommandationMDL.recommandationRef
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .where('eat_type', isEqualTo: 'launch')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<RecommandationMDL> _recommandations = [];
      for (var element in querySnapshot.docs) {
        _recommandations.add(RecommandationMDL.fromDocumentSnapshot(element));
      }
      return _recommandations;
    });
  }

  Stream<List<RecommandationMDL>> getStreamOfDinnerRecommandations() {
    return recommandationMDL.recommandationRef
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .where('eat_type', isEqualTo: 'dinner')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<RecommandationMDL> _recommendations = [];
      for (var element in querySnapshot.docs) {
        _recommendations.add(RecommandationMDL.fromDocumentSnapshot(element));
      }
      return _recommendations;
    });
  }
}
