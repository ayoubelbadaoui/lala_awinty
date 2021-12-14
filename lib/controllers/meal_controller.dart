import 'dart:developer';
import 'dart:io';
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


  TextEditingController mealTitle = TextEditingController();
  TextEditingController mealTime = TextEditingController();
  TextEditingController mealDesc = TextEditingController();
  TextEditingController mealVideUrl = TextEditingController();

  String? typeMeal;
  String? budgetMeal;


  _clearInputs(){
    mealTitle.clear();
    mealTime.clear();
    mealDesc.clear();
    mealVideUrl.clear();
  }


  Future uploadMealPic(File pickedImage,String title) async {

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
          snackPosition: SnackPosition.BOTTOM
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
          'Error', 'Merci de choisir une image',
          snackPosition: SnackPosition.BOTTOM,
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
            mealType: meal.mealType,
              youtubeLink: meal.youtubeLink,
            description: meal.description
          ));
      _clearInputs();
      Get.snackbar(
        'Succès', 'le repas a été ajouté avec succès',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    }
    on FirebaseAuthException catch(e){
      Get.snackbar(
          'Error', 'Merci de choisir une image',
          snackPosition: SnackPosition.BOTTOM
      );
      return false;
    }
  }


  Future<void> pickImageMeal() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    obsImageTho.value= image!.path;
    log('abs path ${obsImageTho.value}');
  }

  Future<List<MealModel>> getListOfMeals() async{

    List <MealModel> _meals = [];
     await MealModel().mealRef.orderBy('at',descending: true).get().then((snapshot) => snapshot.docs.forEach((mealData) {
        _meals.add(mealData.data());
    }));

    return _meals;
  }

  Future<void> deleteMeal(String? id) async {
    await MealModel().mealRef.doc(id!).delete();
  }
}