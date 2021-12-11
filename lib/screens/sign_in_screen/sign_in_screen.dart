import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/constants/firebase.dart';
import 'package:lala_awinty/widgets/app_input.dart';
import 'package:lala_awinty/widgets/app_logo.dart';
import 'package:lala_awinty/widgets/primary_button.dart';

final _formKey = GlobalKey<FormState>();

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
                      'Se connecter',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    AppInput(
                      controller: authController.email,
                      hint: 'Email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      validator: (String? email) {
                        if (email!.isEmpty || !email.isEmail) {
                          return 'Merci d\'enter votre email valid';
                        }
                      },
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
                      validator: (String? pass) {
                        if (pass!.isEmpty) {
                          return 'Merci d\'enter un votre password';
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
                          authController.signIn(context);
                        }
                      },
                      text: 'Se connecter',
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
