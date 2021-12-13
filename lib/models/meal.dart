import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lala_awinty/models/recommandation.dart';

class MealModel extends RecommandationMDL{
  MealModel({
      String? title,
      String? priceRange,
      String? timeToMake,
      String? photoURL,
     String? mealType,
  }):super(
    title: title,
    priceRange: priceRange,
    photoURL: photoURL,
    timeToMake: timeToMake,
    mealType: mealType
  );


  MealModel.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    priceRange: json['priceRange']! as String,
    photoURL: json['photoURL']! as String,
    timeToMake: json['timeToMake']! as String,
  );


  @override
  Map<String, Object?> toJson() {
    return {
      'title': title,
      'priceRange': priceRange,
      'timeToMake': timeToMake,
      'photoURL': photoURL,
      'typeMeal': mealType,
    };
  }

  final mealRef = FirebaseFirestore.instance
      .collection('meals')
      .withConverter<RecommandationMDL>(
    fromFirestore: (snapshot, _) => MealModel.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

}