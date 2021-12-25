import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/models/recommandation.dart';

class MealModel extends RecommandationMDL {
  MealModel({
    String? title,
    String? priceRange,
    String? timeToMake,
    String? photoURL,
    String? mealType,
    Timestamp? at,
    String? youtubeLink,
    String? description,
    String? id,
  }) : super(
            title: title,
            priceRange: priceRange,
            photoURL: photoURL,
            timeToMake: timeToMake,
            mealType: mealType,
            at: at,
            youtubeLink: youtubeLink,
            description: description,
            id: id);

  MealModel.fromJson(Map<String, Object?> json, String id)
      : this(
            title: json['title']! as String,
            priceRange: json['priceRange']! as String,
            timeToMake: json['timeToMake']! as String,
            photoURL: json['photoURL']! as String,
            mealType: json['typeMeal']! as String,
            at: json['at']! as Timestamp,
            youtubeLink: json['youtubeLink']! as String,
            description: json['description']! as String,
            id: id);

  @override
  Map<String, Object?> toJson() {
    return {
      'title': title,
      'priceRange': mealController.budgetMeal ?? '20-30',
      'timeToMake': timeToMake,
      'photoURL': photoURL,
      'typeMeal': mealController.typeMeal ?? 'Déjeuner',
      'at': FieldValue.serverTimestamp(),
      'youtubeLink': youtubeLink,
      'description': description,
    };
  }

  final mealRef =
      FirebaseFirestore.instance.collection('meals').withConverter<MealModel>(
            fromFirestore: (snapshot, _) =>
                MealModel.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (meal, _) => meal.toJson(),
          );
}
