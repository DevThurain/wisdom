import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class CustomDialogBox extends StatefulWidget {
  final String? title, descriptions;
  final String? titleImage;
  final Function? onClickButton;
  final bool? isForceUpdate;

  const CustomDialogBox({
    Key? key,
    this.title,
    this.descriptions,
    this.titleImage,
    this.onClickButton,
    this.isForceUpdate = false,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.3,
        minWidth: double.infinity,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppDimen.MARGIN_CARD_MEDIUM),
            child: Column(
              children: [
                SizedBox(
                  height: AppDimen.MARGIN_CARD_MEDIUM,
                ),
                FittedBox(
                  child: Text(
                    widget.title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.dark_purple,
                      fontSize: AppDimen.TEXT_REGULAR_3X,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.descriptions!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.dark_purple,
                    fontSize: AppDimen.TEXT_REGULAR_2X,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  height: 48,
                  color: Colors.redAccent,
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          widget.isForceUpdate!? SizedBox() :  SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Close",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.dark_purple,
                    fontSize: AppDimen.TEXT_REGULAR_2X,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
          SizedBox(
            height:  widget.isForceUpdate!? AppDimen.MARGIN_MEDIUM_3 :  AppDimen.MARGIN_MEDIUM,
          ),
        ],
      ),
    );
  }
}
