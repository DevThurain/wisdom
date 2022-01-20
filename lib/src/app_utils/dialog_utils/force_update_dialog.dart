import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/hyper_text_view_util.dart';
import 'package:wisdom/src/data_models/vos/app_version_vo.dart';

class ForceUpdateDialog extends StatefulWidget {
  final String? title, descriptions;
  final bool? isForceUpdate;
  final AppVersionVo appVersionVo;

  const ForceUpdateDialog({
    Key? key,
    this.title,
    this.descriptions,
    required this.appVersionVo,
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
        borderRadius: BorderRadius.circular(
          AppDimen.MARGIN_MEDIUM_2,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, widget.appVersionVo),
    );
  }

  contentBox(context, AppVersionVo appVersionVo) {
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
                        onTap: () {
                          HyperTextViewUtil.launchURL(appVersionVo.storeURL.toString());
                        },
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
                        onTap: () {
                          HyperTextViewUtil.launchURL(appVersionVo.directURL.toString());
                        },
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
            height:
                widget.isForceUpdate! ? AppDimen.MARGIN_MEDIUM_3 : AppDimen.MARGIN_MEDIUM,
          ),
        ],
      ),
    );
  }
}
