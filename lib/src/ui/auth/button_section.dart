import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class ButtonSectionV2 extends StatelessWidget {
  final AnimationController animationController;
  final Function onPressed;
  const ButtonSectionV2(
      {Key? key, required this.animationController, required this.onPressed})
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

    final _iconMovedAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(4, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.elasticInOut,
      ),
    ));

    final _singUpAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _topMoveAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 2)).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 145.0),
      child: SlideTransition(
        position: _topMoveAnimation,
        child: ScaleTransition(
          scale: _enterAnimation,
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () {
                    onPressed();
                  },
                  child: Container(
                    height: 58,
                    width: 58 + (200 * _widthAnimation.value),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(8 + 32 * (1 - _widthAnimation.value)),
                      color: AppTheme.white,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SlideTransition(
                            position: _iconMovedAnimation,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.fresh_purple,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: FadeTransition(
                            opacity: _singUpAnimation,
                            child: Text(
                              'register',
                              style: TextStyle(
                                  color: AppTheme.fresh_purple,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
