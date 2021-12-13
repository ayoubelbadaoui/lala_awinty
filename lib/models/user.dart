import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String? id;
  String? name;
  String? email;
  bool? admin;

  UserModel({this.id, this.name, this.email,this.admin});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          //id: json['id']! as String,
          name: json['name']! as String,
          email: json['email']! as String,
          admin :json['admin']! as bool
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'admin':false
    };
  }

  final usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

}
