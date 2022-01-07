import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

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
        decoration:  BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              AppTheme.dark_purple,
              AppTheme.fresh_purple,
            ])),
      ),
    );
  }
}
