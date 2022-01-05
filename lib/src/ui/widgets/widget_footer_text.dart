import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class FooterText extends StatelessWidget {
  const FooterText({required this.text, Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppTheme.black.withOpacity(0.5),
          fontSize: AppDimen.TEXT_REGULAR,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal),
    );
  }
}
