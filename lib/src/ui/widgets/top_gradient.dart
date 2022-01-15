import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class TopGradient extends StatelessWidget {
  const TopGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
              Color(0xffb7b7f5),
              Color(0xffe7e7f8),
              AppTheme.white,
            ])),
      ),
    );
  }
}
