import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/firebase.dart';
import 'package:lala_awinty/core/firebase_init.dart';
import 'package:lala_awinty/helpers/showLoading.dart';
import 'package:lala_awinty/main.dart';
import 'package:lala_awinty/models/user.dart';
import 'package:lala_awinty/screens/auth_screen/welcome_auth_screen.dart';
import 'package:lala_awinty/screens/home_screen/home_screen.dart';
import 'package:lala_awinty/screens/introduction_screen.dart';

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
      Get.offAll(() => IntroScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  Future signIn(BuildContext context) async {
    try {
      showLoading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
      Navigator.pop(context);
    }
  }

  Future<void> signUp(BuildContext context) async {
    showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) async {
        String _userId = result.user!.uid;
        await _addUserToFirestore(_userId);
        await _initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
      Navigator.pop(context);
    }
  }

  Future<void> signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(userID) async {
    await userModel.value.usersRef
        .doc(auth.currentUser!.uid)
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

  Future<bool> checkIfUserIsAdmin() async {
    return await UserModel()
        .usersRef
        .doc(auth.currentUser!.uid)
        .get()
        .then((snapshot) => snapshot.data()!.admin!);
  }
}
