import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class ErrorHandlingDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final AlertType alertType;

  ErrorHandlingDialogBox({
    Key? key,
    required this.title,
    required this.message,
    this.alertType = AlertType.NORMAL,
  }) : super(key: key);

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
        maxHeight: MediaQuery.of(context).size.height * 0.3,
        minWidth: double.infinity,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: alertType.getAlertColor,
                      fontSize: AppDimen.TEXT_REGULAR_3X,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: -8,
                  right: -8,
                  child: IconButton(
                    padding: EdgeInsets.all(0.0),
                    color: AppTheme.fresh_purple,
                    icon: Icon(
                      Icons.cancel_sharp,
                      size: 18.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 0.5, color: AppTheme.dark_purple.withOpacity(0.3),),
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.dark_purple,
                  fontSize: AppDimen.TEXT_REGULAR_2X,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

enum AlertType {
  NORMAL,
  SUCCESS,
  WARNING,
  ERROR,
}

extension AlertColor on AlertType {
  Color get getAlertColor {
    switch (this) {
      case AlertType.NORMAL:
        return AppTheme.dark_purple;
      case AlertType.SUCCESS:
        return AppTheme.success_color;
      case AlertType.WARNING:
        return AppTheme.warning_color;
      case AlertType.ERROR:
        return AppTheme.error_color;
      default:
        return AppTheme.dark_purple;
    }
  }
}
