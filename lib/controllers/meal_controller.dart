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

  String? typeMeal = 'Déjeuner';
  String? budgetMeal = '20-30';


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
          .ref("/meals-photos/${pickedImage.path.removeAllWhitespace.trim()}")
          .putData(file);

      String mealPhotoUrl = await firebase_storage.FirebaseStorage.instance
          .ref("/meals-photos/${pickedImage.path.removeAllWhitespace.trim()}").getDownloadURL();

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

  Future<void> editMeal(String mealId,MealModel meal)async {

   try{
     await  MealModel().mealRef.doc(mealId).update({
       'title': meal.title,
       'priceRange': meal.priceRange,
       'timeToMake': meal.timeToMake,
       //'photoURL': meal.photoURL,
       'typeMeal': meal.mealType,
       'at':meal.at,
       'youtubeLink':meal.youtubeLink,
       'description':meal.description,
     });
     Get.snackbar(
       'Succès', 'le repas a été modifié avec succès',
       snackPosition: SnackPosition.BOTTOM,
     );
   }
   on FirebaseAuthException catch(e){
     Get.snackbar(
         'Error', e.message.toString(),
         snackPosition: SnackPosition.BOTTOM
     );
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
            title: meal.title!.trim(),
            priceRange: meal.priceRange!.trim(),
            timeToMake: meal.timeToMake!.trim(),
            photoURL: mealPhotoUrl!.trim(),
            mealType: meal.mealType!.trim(),
              youtubeLink: meal.youtubeLink!.trim(),
            description: meal.description!.trim()
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

  Future<MealModel> getMealWithID(String mealId) async{
    MealModel _meal = MealModel();
    _meal = await MealModel().mealRef.doc(mealId).get().then((value) => value.data()!);
    return _meal;
  }

  Future<void> deleteMeal(String? id) async {
    await MealModel().mealRef.doc(id!).delete();
  }
}