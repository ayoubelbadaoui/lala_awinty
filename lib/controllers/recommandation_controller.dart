import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/constants/firebase.dart';
import 'package:lala_awinty/models/recommandation.dart';
import 'package:lala_awinty/models/user.dart';

class RecommandationsController extends GetxController {
  static RecommandationsController instance = Get.find();


  RecommandationMDL recommandationMDL = RecommandationMDL();
  
  Stream<List<RecommandationMDL>> getStreamOfLaunchRecommandations(){

    return recommandationMDL.recommandationRef.where('user_id',isEqualTo: auth.currentUser!.uid).where('eat_type',isEqualTo: 'launch').snapshots().map((QuerySnapshot querySnapshot){

      List<RecommandationMDL> _recommandations = [];
      querySnapshot.docs.forEach((DocumentSnapshot element) {
        _recommandations.add(RecommandationMDL.fromDocumentSnapshot(element));
      });
      return _recommandations;
    });

  }

  Stream<List<RecommandationMDL>> getStreamOfDinnerRecommandations(){

    return recommandationMDL.recommandationRef.where('user_id',isEqualTo: auth.currentUser!.uid).where('eat_type',isEqualTo: 'dinner').snapshots().map((QuerySnapshot querySnapshot){

      List<RecommandationMDL> _recommandations = [];
      querySnapshot.docs.forEach((DocumentSnapshot element) {
        _recommandations.add(RecommandationMDL.fromDocumentSnapshot(element));
      });
      return _recommandations;
    });

  }

}
