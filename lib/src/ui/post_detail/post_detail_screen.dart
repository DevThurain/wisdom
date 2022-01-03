import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/expanded_view_port.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/widget_comment_item.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = '/post_detail_screen';

  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  double get _statusBarHeight {
    return MediaQuery.of(context).padding.top;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: _statusBarHeight),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: PostDetailSectionView(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                    bottom: 80,
                    top: AppDimen.MARGIN_LARGE,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) =>
                          CommentItemWidget(
                            name: "Ma Ma",
                            profileUrl: 'assets/images/girl_light.png',
                            commentText: "$index",
                            duration: "2W",
                          ),
                      childCount: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppTheme.comment_box_bg_color,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      minLines: 1,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: AppDimen.TEXT_REGULAR_2X,
                        fontFamily: 'MyanUni',
                        letterSpacing: 0.5,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                          fontSize: AppDimen.TEXT_REGULAR_2X,
                          fontFamily: 'MyanUni',
                          letterSpacing: 0.5,
                        ),
                        hintText: "Enter comment here ...",
                        contentPadding: EdgeInsets.all(
                          AppDimen.MARGIN_CARD_MEDIUM_2,
                        ),
                        fillColor: AppTheme.comment_box_bg_color,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.send_rounded, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(AppDimen.MARGIN_CARD_MEDIUM),
                      shape: CircleBorder(),
                      elevation: 0,
                      primary: AppTheme.fresh_red.withOpacity(0.4),
                      onPrimary: AppTheme.fresh_red.withOpacity(0.4),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  sendMessage() {}
}

class PostDetailSectionView extends StatelessWidget {
  const PostDetailSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.dark_purple.withOpacity(0.1),
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
              padding: const EdgeInsets.all(AppDimen.MARGIN_LARGE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  PostProfileUI(
                    profileUrl: 'assets/images/girl_light.png',
                    color: AppTheme.dark_purple,
                    name: "Ma Ma",
                    duration: "2 Hrs Ago",
                  ),
                  SizedBox(
                    height: AppDimen.MARGIN_MEDIUM_2,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: AppDimen.TEXT_REGULAR_2X,
                      fontFamily: 'MyanUni',
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: AppDimen.MARGIN_MEDIUM_2,
                  ),
                  PostCommentUI(
                    commentCount: "12",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}