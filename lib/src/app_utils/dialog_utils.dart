import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/view_models/profile_provider.dart';

import 'locator.dart';

class ForceUpdateDialog extends StatefulWidget {
  final String? title, descriptions;
  final Function? onClickButton;
  final bool? isForceUpdate;

  const ForceUpdateDialog({
    Key? key,
    this.title,
    this.descriptions,
    this.onClickButton,
    this.isForceUpdate = false,
  }) : super(key: key);

  @override
  _ForceUpdateDialogState createState() => _ForceUpdateDialogState();
}

class _ForceUpdateDialogState extends State<ForceUpdateDialog> {
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
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Fluttertoast.showToast(msg: "Store Link"),
                        child: Container(
                          height: 48,
                          color: Color(0xffb7b7f5).withOpacity(0.5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: AppDimen.MARGIN_MEDIUM,
                              ),
                              Image.asset(
                                'assets/images/download.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(
                                width: AppDimen.MARGIN_MEDIUM,
                              ),
                              Text(
                                "Store link",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.dark_purple,
                                  fontSize: AppDimen.TEXT_REGULAR_2X,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 1,
                      ),
                      GestureDetector(
                        onTap: () => Fluttertoast.showToast(msg: "Direct Link"),
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          color: Color(0xffb7b7f5).withOpacity(0.5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: AppDimen.MARGIN_MEDIUM,
                              ),
                              Image.asset(
                                'assets/images/download.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(
                                width: AppDimen.MARGIN_MEDIUM,
                              ),
                              Text(
                                "Direct link",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.dark_purple,
                                  fontSize: AppDimen.TEXT_REGULAR_2X,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
            height: widget.isForceUpdate!
                ? AppDimen.MARGIN_MEDIUM_3
                : AppDimen.MARGIN_MEDIUM,
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
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
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
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.close,
                          color: AppTheme.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: AppDimen.MARGIN_MEDIUM_2,
              ),
              Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontSize: AppDimen.TEXT_REGULAR,
                  ),
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

class ProfileUpdateDialog extends StatefulWidget {
  final String? title;

  const ProfileUpdateDialog({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  _ProfileUpdateDialogState createState() => _ProfileUpdateDialogState();
}

class _ProfileUpdateDialogState extends State<ProfileUpdateDialog> {
  var profileProvider = locator<ProfileProvider>();
  TextEditingController _nameEditingController = TextEditingController();

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
                    widget.title ?? "",
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
                  height: AppDimen.MARGIN_LARGE,
                ),
                TextField(
                  controller: _nameEditingController,
                  autofocus: false,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimen.MARGIN_MEDIUM),
                      ),
                      borderSide: BorderSide(
                          color: AppTheme.dark_purple.withOpacity(0.2)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimen.MARGIN_MEDIUM),
                      ),
                      borderSide: BorderSide(
                          color: AppTheme.dark_purple.withOpacity(0.3)),
                    ),
                    filled: true,
                    hintStyle: TextStyle(
                      color: Color(0xffAFAFBD).withOpacity(
                        0.5,
                      ),
                      height: 1,
                    ),
                    hintText: "Enter Nick Name Here",
                    contentPadding: EdgeInsets.all(
                      AppDimen.MARGIN_CARD_MEDIUM_2,
                    ),
                    fillColor: AppTheme.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: 48,
                            color: Color(0xffb7b7f5).withOpacity(0.5),
                            child: Center(
                              child: Text(
                                "Close",
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
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => {
                            profileProvider
                                .saveNickName(_nameEditingController.text),
                            Navigator.pop(context)
                          },
                          child: Container(
                            height: 48,
                            margin: EdgeInsets.only(left: 1),
                            width: double.infinity,
                            color: Color(0xffb7b7f5).withOpacity(0.5),
                            child: Center(
                              child: Text(
                                "Save",
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
