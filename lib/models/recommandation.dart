import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lala_awinty/constants/enums.dart';
import 'package:lala_awinty/constants/enums.dart';

class RecommandationMDL{

  String? title;
  String? priceRange;
  String? rating;
  String? timeToMake;
  String? youtubeLink;
  Timestamp? at;
  String? id;
  String? photoURL;
  String? mealType;
  String? description;

  RecommandationMDL({this.description,this.youtubeLink,this.mealType,this.id,this.at,this.priceRange,this.rating,this.timeToMake,this.title,this.photoURL});


  RecommandationMDL.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    priceRange: json['priceRange']! as String,
    rating: json['rating']! as String,
    timeToMake: json['timeToMake']! as String,
    at: json['at']! as Timestamp,
    photoURL: json['photoURL']! as String,
    youtubeLink: json['youtubeLink']! as String,
    description: json['description']! as String,
  );


  RecommandationMDL.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot,
      ){
    id = documentSnapshot.id;
    at = documentSnapshot.get('at');
    timeToMake = documentSnapshot.get('timeToMake');
    title = documentSnapshot.get('title');
    priceRange = documentSnapshot.get('priceRange');
    rating = documentSnapshot.get('rating');
    photoURL = documentSnapshot.get('photoURL');
  }

  //TODO : we normally don't need this only for adding
  Map<String, Object?> toJson() {
    return {
      'title': title,
      'priceRange': priceRange,
      'rating': rating,
      'photoURL': photoURL,
      'timeToMake': timeToMake,
      'description': description,
    };
  }

  final recommandationRef = FirebaseFirestore.instance
      .collection('recommandations')
      .withConverter<RecommandationMDL>(
    fromFirestore: (snapshot, _) => RecommandationMDL.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

}