import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'auth_screen/welcome_auth_screen.dart';

class IntroScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.to(WelcomeAuthScreen());
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg',
          width: MediaQuery.of(context).size.width * .58),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    SystemChrome.setEnabledSystemUIOverlays([]);

    //this is to prevent (land scope) mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome to Karam",
          body:
              "Vous êtes altruiste, aider les exclus sociaux cela fait partie de vos principes de vie.",
          image: _buildImage('1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Charity",
          body:
              "Karam est une application qui permet de générer des fonds pour optimiser le travail de l’Association Maghreb Secours (AMS).",
          image: _buildImage('2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Karam love",
          body:
              "Si vous voulez augmenter votre Karma, partagez au maximum cette application avec vos contacts. Profitez du chat pour vous faire des nouveaux amis.",
          image: _buildImage('3'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('clique',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
