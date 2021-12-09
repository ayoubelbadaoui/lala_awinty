import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/widgets/app_input.dart';
import 'package:lala_awinty/widgets/app_logo.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: FractionallySizedBox(
          widthFactor: .75,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * .18,),
                AppLogo(),
                SizedBox(height: Get.height * .09,),
                Text(
                    'S\'inscrire',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: Get.height * .035,),
                AppInput(
                  hint: 'Nom et prenom',
                  prefixIcon: Icon(Icons.account_circle,color: Colors.black,),
                ),
                SizedBox(height: Get.height * .015,),
                AppInput(
                  hint: 'Email',
                  prefixIcon: Icon(Icons.email,color: Colors.black,),
                ),
                SizedBox(height: Get.height * .015,),
                AppInput(
                  hint: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock,color: Colors.black,),
                ),
                SizedBox(height: Get.height * .022,),
                AppPrimaryButton(
                    onPressed: null, text: 'S\'inscrire',
                  width: Get.width,
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
