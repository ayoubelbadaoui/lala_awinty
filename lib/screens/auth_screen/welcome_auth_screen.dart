import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/screens/sign_in_screen/sign_in_screen.dart';
import 'package:lala_awinty/screens/sign_up_screen/sign_up_screen.dart';
import 'package:lala_awinty/widgets/app_logo.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

class WelcomeAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * .28,),
              Center(child: AppLogo()),
               SizedBox(height: Get.height * .07,),
               FractionallySizedBox(
                  child: Text(
                      'The smartest way to give & get recommendations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Get.width * .04
                      ),
                  ),
                widthFactor: .7,
              ),
              SizedBox(height: Get.height * .04,),
              Center(child: AppPrimaryButton(
                onPressed: ()=>  Get.to( const SignUpScreen()),
                text: 'Commencer',
              )),
              const SizedBox(height: 20,),
               GestureDetector(
                 onTap: ()=>Get.to(const SignInScreen()),
                 child: FractionallySizedBox(
                  child: Text(
                    'Vous avez déjà un compte ?',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Get.width * .03
                      )
                  ),
                  widthFactor: .7,
              ),
               ),

            ],
          ),
        ),
      ),
    );
  }

}