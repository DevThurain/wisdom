import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/register/register_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/gradient_background.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _goToRegisterScreen();
    super.initState();
  }

  _goToRegisterScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamed(context, RegisterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations.of(context)!.appTitle.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: AppDimen.TEXT_REGULAR_3X,
                              fontFamily: 'Poppins',
                              letterSpacing: 5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const PersonCardSection(),
                      //const ButtonSectionView()
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class PersonCardSection extends StatelessWidget {
  const PersonCardSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppDimen.MARGIN_MEDIUM_3)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -15,
            top: -15,
            child: CircularPersonFace(
              width: 35,
              imgPath: 'assets/images/girl_light.png',
            ),
          ),
          Positioned(
            right: -15,
            top: -90,
            child: CircularPersonFace(
              width: 28,
              imgPath: 'assets/images/girl_light_2.png',
            ),
          ),
          Positioned(
            right: -2,
            bottom: -10,
            child: CircularPersonFace(
              width: 32,
              imgPath: 'assets/images/girl_light_3.png',
            ),
          ),
          Positioned(
            left: -2,
            bottom: -20,
            child: CircularPersonFace(
              width: 25,
              imgPath: 'assets/images/boy_light.png',
            ),
          ),
          Positioned(
            right: 50,
            top: 50,
            child: CircularPersonFace(
              width: 27,
              imgPath: 'assets/images/boy_light_2.png',
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  top: AppDimen.MARGIN_MEDIUM_3, left: AppDimen.MARGIN_LARGE),
              child: Text(
                'Let\'s\nFun\nTogether',
                style: TextStyle(
                  fontSize: AppDimen.TEXT_HEADING_3X,
                  color: AppTheme.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
