import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:lala_awinty/models/meal.dart';

class MealController extends GetxController{

  static MealController instance = Get.find();

  Rx<MealModel> mealModel = MealModel().obs;
  final ImagePicker _picker = ImagePicker();
  Rx<String> obsImageTho ="".obs;


  TextEditingController? mealTitle;
  TextEditingController? mealType;


  _clearImput(){
    mealTitle!.clear();
    mealType!.clear();
  }


  Future uploadMealPic(File pickedImage,String title) async {

    print('uploadss');

    var file =await pickedImage.readAsBytes();


    try{
      await firebase_storage.FirebaseStorage.instance
          .ref("/meals-photos/${title.toString().removeAllWhitespace.trim()}")
          .putData(file);

      String mealPhotoUrl = await firebase_storage.FirebaseStorage.instance
          .ref("/meals-photos/${title.toString().removeAllWhitespace.trim()}").getDownloadURL();

      return mealPhotoUrl;
    }
    catch(e){
      Get.snackbar(
        "Error",
        "image not uploaded ${e.toString()}",
      );
      return;
    }
  }




  Future addNewMeal(MealModel meal) async{

    File file = File(obsImageTho.value);

    String? mealPhotoUrl;
    try{
      mealPhotoUrl = await uploadMealPic(file,meal.title!);
      print('meal link ${mealPhotoUrl}');
    }
    catch(e){
      Get.snackbar(
        "Error",
        "image not uploaded ${e}",
      );
      return false;
    }

    try{
      MealModel().mealRef.add(
          MealModel(
            title: meal.title,
            priceRange: meal.priceRange,
            timeToMake: meal.timeToMake,
            photoURL: mealPhotoUrl,
            mealType: meal.mealType
          ));
      _clearImput();
      return true;
    }
    on FirebaseAuthException catch(e){
      Get.snackbar('Error', '${e.code}');
      return false;
    }
  }


  Future<void> pickImageMeal() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    obsImageTho.value= image!.path;
    log('abs path ${obsImageTho.value}');
  }

}