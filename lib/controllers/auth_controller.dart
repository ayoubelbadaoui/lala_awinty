import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/firebase.dart';
import 'package:lala_awinty/core/firebase_init.dart';
import 'package:lala_awinty/helpers/showLoading.dart';
import 'package:lala_awinty/models/user.dart';
import 'package:lala_awinty/screens/auth_screen/welcome_auth_screen.dart';
import 'package:lala_awinty/screens/home_screen/home_screen.dart';

import '../main.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<User?>? firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser!.bindStream(auth.userChanges());
    ever(firebaseUser!, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => MyApp());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void signIn() async {
    try {
      showLoading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        //_initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp() async {
    showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      //debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    }
  }

  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(userID) async {
    await userModel.value.usersRef
        .doc()
        .set(UserModel(name: name.text.trim(), email: email.text.trim()));
  }

  _initializeUserModel(String userId) async {
    userModel.value = await userModel.value.usersRef
        .doc(userId)
        .get()
        .then((snapshot) => snapshot.data()!);
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }
}
