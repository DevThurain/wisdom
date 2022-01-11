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
          widget.isForceUpdate!
              ? SizedBox()
              : SizedBox(
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
            height:
                widget.isForceUpdate! ? AppDimen.MARGIN_MEDIUM_3 : AppDimen.MARGIN_MEDIUM,
          ),
        ],
      ),
    );
  }
}

class ErrorDialogBox extends StatelessWidget {
  final String title;
  final String message;

  ErrorDialogBox({Key? key, required this.title, required this.message})
      : super(key: key);

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
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.fresh_purple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimen.MARGIN_MEDIUM_2),
                    topRight: Radius.circular(AppDimen.MARGIN_MEDIUM_2),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: AppDimen.TEXT_REGULAR_2X,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppDimen.MARGIN_MEDIUM_2,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.black,
                  fontSize: AppDimen.TEXT_REGULAR,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DialogUtils {
    void showErrorDialog(BuildContext ctx, String title, String message) {
    showDialog(
        context: ctx,
        barrierDismissible: true,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: ErrorDialogBox(
              title: title,
              message: message,
            ),
          );
        });
  }

}
