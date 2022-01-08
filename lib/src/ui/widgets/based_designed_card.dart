import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class BasedDesignedCard extends StatelessWidget {
  final Color color;
  final Widget child;
  const BasedDesignedCard({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimen.MARGIN_CARD_MEDIUM_2),
      margin: EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: color.withOpacity(0.1)),
      child: child,
    );
  }
}
