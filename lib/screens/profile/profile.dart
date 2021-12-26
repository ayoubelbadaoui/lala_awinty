import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/firebase.dart';

import '../introduction_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Logout'),
            IconButton(onPressed: ()async{
              await auth.signOut();
              Get.offAll(IntroScreen());
            }, icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
