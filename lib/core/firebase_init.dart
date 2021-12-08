import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lala_awinty/widgets/loading_widget.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FireBaseInitializationWidget extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final Widget loggedInScreen;
  final Widget loggedOutScreen;

  static String id = "init_services_widget";

  FireBaseInitializationWidget(
      {required this.loggedOutScreen, required this.loggedInScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          // Once complete, show KARAM application
          if (snapshot.connectionState == ConnectionState.done) {
            if (auth.currentUser != null) {
              //print('email : ${AuthController.auth.currentUser!.email}');
              return loggedInScreen;
            }
            return loggedOutScreen;
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: LoadingWidget(),
          );
        },
      ),
    );
  }
}
