import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/auth/button_section.dart';
import 'package:wisdom/src/ui/auth/login_section.dart';
import 'package:wisdom/src/ui/auth/register_section.dart';
import 'package:wisdom/src/ui/auth/refer_code_section.dart';
import 'package:wisdom/src/ui/auth/title_section.dart';
import 'package:wisdom/src/ui/widgets/gradient_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/register_screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    _animationController.animateTo(0.0);
    _animationController.animateTo(0.2);

    super.initState();
  }

  _onNext() {
    if (_animationController.value >= 0.0 && _animationController.value < 0.4) {
      _animationController.animateTo(0.4);
    } else if (_animationController.value >= 0.4 && _animationController.value < 0.6) {
      _animationController.animateTo(0.6);
    } else if (_animationController.value >= 0.6 && _animationController.value < 0.8) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  _onExit() {
    if (_animationController.value >= 0.4 && _animationController.value < 0.6)
      _animationController.animateTo(0.2);
    else if (_animationController.value >= 0.6 && _animationController.value < 0.8)
      _animationController.animateTo(0.4);
    else {
       if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onExit();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            GradientBackground(),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TitleSection(animationController: _animationController),
                        SizedBox(height: AppDimen.MARGIN_MEDIUM_3),
                        Stack(
                          children: [
                            Stack(
                              children: [
                                LoginSection(
                                  animationController: _animationController,
                                  onPressRegister: () {
                                    _animationController.animateTo(0.4);
                                  },
                                  onPressLogin: () {
                                    Navigator.pushNamed(context, HomeScreen.routeName);
                                  },
                                ),
                                ReferCodeSection(
                                    animationController: _animationController),
                                RegisterSection(animationController: _animationController),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ButtonSectionV2(
                                  animationController: _animationController,
                                  onPressed: () {
                                    _onNext();
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppTheme.fresh_purple,
      ),
      child: InkWell(
        child: Center(
          child: Text(
            'Register',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AppTheme.white,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldTitle extends StatelessWidget {
  final String text;

  TextFieldTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: AppTheme.white,
          fontSize: AppDimen.TEXT_REGULAR_2X,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal),
    );
  }
}
