import 'package:flutter/material.dart';
import 'package:lala_awinty/constants/controllers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => authController.signOut(),
        child: Center(
          child: Text('Logged in'),
        ),
      ),
    );
  }
}
