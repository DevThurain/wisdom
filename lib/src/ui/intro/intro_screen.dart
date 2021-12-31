import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          CustomScrollView(
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
                      const ButtonSectionView()
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

class ButtonSectionView extends StatelessWidget {
  const ButtonSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: TextField(
            decoration: InputDecoration(
                fillColor: AppTheme.white,
                filled: true,
                hintText: 'Nick Name ...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppTheme.black.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                )),
          ),
        ),
        SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Register',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppTheme.white,
                ),
              ),
            ))
      ],
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
        color: AppTheme.white.withOpacity(0.2),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -15,
            top: -15,
            child: PersonFace(
              width: 35,
              imgPath: 'assets/images/girl_light.png',
            ),
          ),
          Positioned(
            right: -15,
            top: -90,
            child: PersonFace(
              width: 28,
              imgPath: 'assets/images/girl_light.png',
            ),
          ),
          Positioned(
            right: -2,
            bottom: -10,
            child: PersonFace(
              width: 32,
              imgPath: 'assets/images/girl_light.png',
            ),
          ),
          Positioned(
            left: -2,
            bottom: 0,
            child: PersonFace(
              width: 25,
              imgPath: 'assets/images/girl_light.png',
            ),
          ),
          Positioned(
            right: 50,
            top: 50,
            child: PersonFace(
              width: 27,
              imgPath: 'assets/images/girl_light.png',
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

class PersonFace extends StatelessWidget {
  final double width;
  final String imgPath;

  PersonFace({required this.width, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: AppTheme.white)),
      child: CircleAvatar(
        backgroundImage: AssetImage(imgPath),
        radius: width,
      ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              AppTheme.fresh_red,
              AppTheme.fresh_purple,
            ])),
      ),
    );
  }
}
