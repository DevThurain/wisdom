import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/intro/intro_screen.dart';
import 'package:wisdom/src/ui/register/button_section.dart';
import 'package:wisdom/src/ui/register/name_section.dart';
import 'package:wisdom/src/ui/register/refer_code_section.dart';
import 'package:wisdom/src/ui/widgets/based_designed_card.dart';
import 'package:wisdom/src/ui/widgets/custom_text_field.dart';
import 'package:wisdom/src/ui/widgets/gradient_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    _animationController.animateTo(0.0);
    _animationController.animateTo(0.2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_animationController.value >= 0.4 && _animationController.value < 0.6)
          _animationController.animateTo(0.2);
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
                        SizedBox(
                          width: double.infinity,
                          child: WisdomLogo(),
                        ),
                        SizedBox(height: AppDimen.MARGIN_MEDIUM_3),

                        Stack(
                          children: [
                            RefercodeSection(animationController: _animationController),
                            NameSection(animationController: _animationController),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ButtonSectionV2(
                                  animationController: _animationController,
                                  onPressed: () {
                                    if (_animationController.value > 0.0 &&
                                        _animationController.value < 0.4)
                                      _animationController.animateTo(0.4);
                                    if (_animationController.value >= 0.4 &&
                                        _animationController.value < 0.6)
                                      _animationController.animateTo(0.6);
                                  }),
                            )
                          ],
                        ),
                        // BasedDesignedCard(
                        //   color: AppTheme.white,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       TextFieldTitle(text: "refer code"),
                        //       SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
                        //       CustomTextField(
                        //         onChanged: (value) {},
                        //         hint: 'code',
                        //         textInputAction: TextInputAction.next,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: AppDimen.MARGIN_MEDIUM_3),

                        // BasedDesignedCard(
                        //   color: AppTheme.white,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       TextFieldTitle(text: "enter your nickname"),
                        //       SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
                        //       CustomTextField(
                        //         onChanged: (value) {},
                        //         hint: 'nick name',
                        //         textInputAction: TextInputAction.next,
                        //       ),
                        //       SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM_2),
                        //       TextFieldTitle(text: "password"),
                        //       SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
                        //       CustomTextField(
                        //         onChanged: (value) {},
                        //         hint: 'password',
                        //         textInputAction: TextInputAction.next,
                        //       ),
                        //       // SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM_2),
                        //       // TextFieldTitle(text: "confirm password"),
                        //       // SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
                        //       // CustomTextField(
                        //       //   onChanged: (value) {},
                        //       //   hint: 'confirm password',
                        //       //   textInputAction: TextInputAction.done,
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: AppDimen.MARGIN_MEDIUM_3),
                        // ButtonSectionView(),

                        //const ButtonSectionView()
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

class WisdomLogo extends StatelessWidget {
  const WisdomLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.appTitle.toUpperCase(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: AppTheme.white,
          fontSize: AppDimen.TEXT_REGULAR_3X,
          fontFamily: 'Poppins',
          letterSpacing: 5,
          fontWeight: FontWeight.bold),
    );
  }
}
