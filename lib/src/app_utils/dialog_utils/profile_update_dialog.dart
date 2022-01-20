import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/view_models/profile_provider.dart';

class ProfileUpdateDialog extends StatefulWidget {
  final String? title;
  final ProfileProvider? profileProvider;

  const ProfileUpdateDialog({
    Key? key,
    this.title,
    this.profileProvider
  }) : super(key: key);

  @override
  _ProfileUpdateDialogState createState() => _ProfileUpdateDialogState();
}

class _ProfileUpdateDialogState extends State<ProfileUpdateDialog> {
  final TextEditingController _nameEditingController = TextEditingController();

  ProfileProvider get profileProvider => widget.profileProvider!;

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
