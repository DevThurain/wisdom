import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/auth/auth_screen.dart';
import 'package:wisdom/src/ui/widgets/based_designed_card.dart';
import 'package:wisdom/src/ui/widgets/custom_text_field.dart';
import 'package:wisdom/src/ui/widgets/wisdom_logo.dart';

class LoginSection extends StatelessWidget {
  final AnimationController animationController;
  final Function onPressRegister;
  final Function onPressLogin;
  LoginSection(
      {Key? key,
      required this.animationController,
      required this.onPressLogin,
      required this.onPressRegister})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _enterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.elasticInOut,
      ),
    ));

    final _exitAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -2)).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _exitAnimation,
      child: Column(
        children: [
          ScaleTransition(
            scale: _enterAnimation,
            child: SizedBox(
              width: double.infinity,
              child: WisdomLogo(),
            ),
          ),
          SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
          BasedDesignedCard(
            color: AppTheme.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldTitle(text: "enter your nickname"),
                SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
                CustomTextField(
                  onChanged: (value) {},
                  hint: 'nick name',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM_2),
                TextFieldTitle(text: "password"),
                SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
                CustomTextField(
                  onChanged: (value) {},
                  hint: 'password',
                  textInputAction: TextInputAction.next,
                ),
                // SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM_2),
                // TextFieldTitle(text: "confirm password"),
                // SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
                // CustomTextField(
                //   onChanged: (value) {},
                //   hint: 'confirm password',
                //   textInputAction: TextInputAction.done,
                // ),
              ],
            ),
          ),
          SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
          GestureDetector(
              onTap: () {
                onPressRegister();
              },
              child: RegisterText()),
          SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_LARGE),
            child: ScaleTransition(
              scale: _enterAnimation,
              child: LoginButton(
                onPressed: () {
                  onPressLogin();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: const [
        TextSpan(
            text: 'Don\'t have an account?  ',
            style: TextStyle(
              color: AppTheme.white,
              fontFamily: 'Poppins',
            )),
        TextSpan(
            text: 'Register',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: AppTheme.white,
              fontFamily: 'Poppins',
            ))
      ]),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      onPressed: () {
        onPressed();
      },
      color: AppTheme.white,
      splashColor: AppTheme.fresh_purple.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
      child: Center(
          child: Text('Login',
              style: TextStyle(
                color: AppTheme.dark_purple,
                fontFamily: 'Poppins',
              ))),
    );
  }
}
