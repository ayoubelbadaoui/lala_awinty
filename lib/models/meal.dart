import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/models/recommandation.dart';

class MealMDL extends RecommandationMDL {
  MealMDL({
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

  MealMDL.fromJson(Map<String, Object?> json, String id)
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

  MealMDL.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot,
      ){
    id = documentSnapshot.id;
    at = documentSnapshot.get('at');
    timeToMake = documentSnapshot.get('timeToMake');
    title = documentSnapshot.get('title');
    priceRange = documentSnapshot.get('priceRange');
    rating = '4.5';
    photoURL = documentSnapshot.get('photoURL');
    youtubeLink = documentSnapshot.get('youtubeLink');
    description = documentSnapshot.get('description');
    mealType = documentSnapshot.get('typeMeal');
  }

  final mealRef =
      FirebaseFirestore.instance.collection('meals').withConverter<MealMDL>(
            fromFirestore: (snapshot, _) =>
                MealMDL.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (meal, _) => meal.toJson(),
          );
}
