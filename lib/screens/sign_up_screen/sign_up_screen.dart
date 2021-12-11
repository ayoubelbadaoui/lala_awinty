import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/helpers/showLoading.dart';
import 'package:lala_awinty/widgets/app_input.dart';
import 'package:lala_awinty/widgets/app_logo.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

final _formKey = GlobalKey<FormState>();

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: FractionallySizedBox(
          widthFactor: .75,
          child: SingleChildScrollView(
              reverse: true,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * .18,
                    ),
                    AppLogo(),
                    SizedBox(
                      height: Get.height * .09,
                    ),
                    Text(
                      'S\'inscrire',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: Get.height * .035,
                    ),
                    AppInput(
                      controller: authController.name,
                      hint: 'Nom et prenom',
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                      validator: (String? name) {
                        if (name!.isEmpty) {
                          return 'Merci d\'ecrire votre nom';
                        }
                      },
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    AppInput(
                      hint: 'Email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      validator: (String? email) {
                        if (email!.isEmpty || !email.isEmail) {
                          return 'Merci d\'ecrire votre email';
                        }
                      },
                      controller: authController.email,
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    AppInput(
                      controller: authController.password,
                      hint: 'Mot de passe',
                      obscureText: true,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      validator: (String? password) {
                        if (password!.isEmpty) {
                          return 'Merci d\'ecrire votre nom';
                        }
                      },
                    ),
                    SizedBox(
                      height: Get.height * .022,
                    ),
                    AppPrimaryButton(
                      onPressed: () async {
                        //this to hide the keyboard
                        FocusScope.of(context).requestFocus(FocusNode());

                        if (_formKey.currentState!.validate()) {
                          authController.signUp(context);
                        }
                      },
                      text: 'S\'inscrire',
                      width: Get.width,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
