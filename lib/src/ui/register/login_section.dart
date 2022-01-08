import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/register/register_screen.dart';
import 'package:wisdom/src/ui/widgets/based_designed_card.dart';
import 'package:wisdom/src/ui/widgets/custom_text_field.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasedDesignedCard(
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
    );
  }
}
