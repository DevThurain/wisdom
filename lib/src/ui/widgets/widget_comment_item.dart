import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    this.name = "",
    this.profileUrl = "",
    this.commentText = "",
    this.duration = "",
    Key? key,
  }) : super(key: key);
  final String name;
  final String profileUrl;
  final String commentText;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppDimen.MARGIN_XLARGE,
        bottom: AppDimen.MARGIN_CARD_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SquarePersonFace(width: 24, imgPath: profileUrl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.all(AppDimen.MARGIN_MEDIUM),
                    margin: EdgeInsets.symmetric(
                        horizontal: AppDimen.MARGIN_MEDIUM),
                    decoration: BoxDecoration(
                        color: Color(0xffb7b7f5).withOpacity(0.15),
                        borderRadius: BorderRadius.all(
                      Radius.circular(AppDimen.MARGIN_MEDIUM),
                    )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppTheme.dark_purple,
                              fontSize: AppDimen.TEXT_REGULAR_2X,
                              fontFamily: 'MyanUni',
                              height: 1,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: AppDimen.MARGIN_SMALL,
                        ),
                        Text(
                          commentText,
                          textAlign: TextAlign.start,
                          softWrap : true,
                          style: TextStyle(
                              color: AppTheme.black.withOpacity(0.5),
                              fontSize: AppDimen.TEXT_REGULAR,
                              fontFamily: 'MyanUni',
                              height: 1.5,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimen.MARGIN_MEDIUM,
                      top: AppDimen.MARGIN_SMALL,
                    ),
                    child: Text(
                      duration,
                      style: TextStyle(
                          color: Color(0xffAFAFBD),
                          fontSize: AppDimen.TEXT_SMALL,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
