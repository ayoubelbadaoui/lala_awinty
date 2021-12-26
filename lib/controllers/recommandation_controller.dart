import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/constants/firebase.dart';
import 'package:lala_awinty/models/meal.dart';
import 'package:lala_awinty/models/recommandation.dart';
import 'package:lala_awinty/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecommandationsController extends GetxController {
  static RecommandationsController instance = Get.find();

  RxString mealType = 'Déjeuner'.obs;
  RxString priceRange = '20-30'.obs;

  RecommandationMDL recommandationMDL = RecommandationMDL();

  Stream<List<MealMDL>> getStreamOfLaunchRecommandations() {

    print('price range :${priceRange.value}');

    return MealMDL().mealRef
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
    return MealMDL().mealRef
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

  createNewRecommandation(String docID) async {
    List<MealMDL> _meals = [];

    await MealMDL()
        .mealRef
        .where('id_meal', isNotEqualTo: docID.toString())
        .get()
        .then((snapshot) => snapshot.docs.forEach((mealData) {
              RecommandationMDL _recommandation = RecommandationMDL(
                  title: mealData.data().title,
                  id: mealData.data().id,
                  priceRange: mealData.data().priceRange!.trim(),
                  timeToMake: mealData.data().timeToMake!.trim(),
                  photoURL: mealData.data().photoURL!.trim(),
                  mealType: mealData.data().mealType!.trim(),
                  youtubeLink: mealData.data().youtubeLink!.trim(),
                  description: mealData.data().description!.trim());
              addNewRecommandation(_recommandation);
            })).then((value) {
      Get.snackbar(
        'Succès',
        'la recommandation a été ajouté avec succès',
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  Future addNewRecommandation(RecommandationMDL meal) async {
    try {
      RecommandationMDL().recommandationRef.add(RecommandationMDL(
          title: meal.title!.trim(),
          id: meal.id.toString().trim(),
          priceRange: meal.priceRange!.trim(),
          timeToMake: meal.timeToMake!.trim(),
          photoURL: meal.photoURL!.trim(),
          mealType: meal.mealType!.trim(),
          youtubeLink: meal.youtubeLink!.trim(),
          description: meal.description!.trim()));
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Merci de choisir une image',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
}
