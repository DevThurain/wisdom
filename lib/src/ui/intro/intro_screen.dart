import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';
import 'package:wisdom/src/ui/auth/auth_screen.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/gradient_background.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';

  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var sharePreference = locator<SharedPreferenceHelper>();

  @override
  void initState() {
    _goToRegisterScreen();
    super.initState();
  }

  _goToRegisterScreen() async {
    await Future.delayed(Duration(seconds: 2));
    String token = await sharePreference.getString(PREF_AUTH_TOKEN);
    if (token.isEmpty) {
      Navigator.pushReplacementNamed(context, AuthScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
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
                              fontSize: AppDimen.TEXT_HEADING_1X,
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
        borderRadius:
            const BorderRadius.all(Radius.circular(AppDimen.MARGIN_MEDIUM_3)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -15,
            top: -60,
            child: CircularPersonFace(
              width: 35,
              imgPath: 'assets/images/tom.png',
            ),
          ),
          Positioned(
            right: -15,
            top: -90,
            child: CircularPersonFace(
              width: 28,
              imgPath: 'assets/images/larva_red.png',
            ),
          ),
          Positioned(
            right: -2,
            bottom: -10,
            child: CircularPersonFace(
              width: 32,
              imgPath: 'assets/images/ant.png',
            ),
          ),
          Positioned(
            left: -2,
            bottom: -20,
            child: CircularPersonFace(
              width: 25,
              imgPath: 'assets/images/snow_man.png',
            ),
          ),
          Positioned(
            right: 50,
            top: 50,
            child: CircularPersonFace(
              width: 27,
              imgPath: 'assets/images/jerry.png',
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.5,
            bottom: 90,
            child: CircularPersonFace(
              width: 14,
              imgPath: 'assets/images/ice_age_sid.png',
            ),
          ),
          const Positioned(
            left: 0,
            top: 60,
            child: Padding(
              padding: EdgeInsets.only(left: AppDimen.MARGIN_MEDIUM),
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
