import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/widgets/wisdom_logo.dart';

class TitleSection extends StatelessWidget {
  final AnimationController animationController;
  const TitleSection(
      {Key? key, required this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
     final _enterAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.elasticInOut,
      ),
    ));

    return ScaleTransition(
      scale: _enterAnimation,
      child: SizedBox(
        width: double.infinity,
        child: WisdomLogo(),
      ),
    );
  }
}

