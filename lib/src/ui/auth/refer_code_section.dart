import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/auth/auth_screen.dart';
import 'package:wisdom/src/ui/widgets/based_designed_card.dart';
import 'package:wisdom/src/ui/widgets/custom_text_field.dart';

class ReferCodeSection extends StatelessWidget {
  final AnimationController animationController;
  final TextEditingController referCodeController;
 ReferCodeSection({Key? key, required this.animationController, required this.referCodeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _enterAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _exitAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _enterAnimation,
      child: SlideTransition(
        position: _exitAnimation,
        child: BasedDesignedCard(
          color: AppTheme.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldTitle(text: "refer code"),
              SizedBox(height: AppDimen.MARGIN_CARD_MEDIUM),
              CustomTextField(
                controller: referCodeController,
                onChanged: (value) {},
                hint: 'code',
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
