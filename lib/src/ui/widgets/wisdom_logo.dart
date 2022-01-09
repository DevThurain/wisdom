import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

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
