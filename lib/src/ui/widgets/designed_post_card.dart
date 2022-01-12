import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';

class DesignedPostCard extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;
  final String name;
  final String profileUrl;
  final String duration;
  final String commentCount;
  const DesignedPostCard({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
    required this.name,
    required this.duration,
    required this.profileUrl,
    required this.commentCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2, vertical: AppDimen.MARGIN_MEDIUM),
      height: 280,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: color.withOpacity(0.1)),
      child: InkWell(
        splashColor: color.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: () {
          onTap();
        },
        child: Stack(
          children: [
            Positioned(
              right: -150,
              bottom: 0,
              child: Opacity(
                opacity: 0.4,
                child: RotatedBox(
                  //4,1
                  quarterTurns: 3,
                  child: Image.asset(
                    'assets/images/curve_1.png',
                    color: AppTheme.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.MARGIN_MEDIUM_2,
                    vertical: AppDimen.MARGIN_MEDIUM_2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostProfileUI(profileUrl: profileUrl, color: color, name: name,duration: duration,),
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: color,
                          fontSize: AppDimen.TEXT_REGULAR_3X,
                          fontFamily: 'MyanUni',
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold),
                    ),
                    PostCommentUI(
                      commentCount: commentCount,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostCommentUI extends StatelessWidget {
  final String commentCount;

  const PostCommentUI({
    required this.commentCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/ic_comment.png',
          color: AppTheme.black.withOpacity(0.5),
          width: 16,
        ),
        SizedBox(width: AppDimen.MARGIN_MEDIUM),
        Text(
          '$commentCount comment',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppTheme.black.withOpacity(0.5),
              fontSize: AppDimen.TEXT_REGULAR,
              fontFamily: 'MyanUni',
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}

class PostProfileUI extends StatelessWidget {
  final String profileUrl;
  final String name;
  final String duration;
  const PostProfileUI({
    Key? key,
    required this.profileUrl,
    required this.name,
    required this.duration,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SquarePersonFace(width: 40, imgPath: profileUrl),
        SizedBox(width: AppDimen.MARGIN_MEDIUM),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: color,
                  fontSize: AppDimen.TEXT_REGULAR_3X,
                  fontFamily: 'MyanUni',
                  height: 1,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              duration,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffAFAFBD),
                  fontSize: AppDimen.TEXT_SMALL,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal),
            ),
          ],
        )
      ],
    );
  }
}
