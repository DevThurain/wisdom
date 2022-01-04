import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/widget_comment_item.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = '/post_detail_screen';
  final FunItem postItem;

  const PostDetailScreen(this.postItem, {Key? key}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  var funProvider = locator<FunProvider>();

  double get _statusBarHeight {
    return MediaQuery.of(context).padding.top;
  }

  FunItem get _postItem {
    return widget.postItem;
  }

  @override
  void initState() {
    funProvider.getCommentList();
    super.initState();
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostDetailSectionView(_postItem),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () => funProvider.getCommentList(),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimen.MARGIN_MEDIUM,
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Load more comments..",
                            style: TextStyle(
                              fontSize: AppDimen.TEXT_REGULAR,
                              fontFamily: 'MyanUni',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CommentListSectionView(),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: AppDimen.MARGIN_XXLARGE * 2),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.comment_box_bg_color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimen.MARGIN_MEDIUM),
                  topRight: Radius.circular(AppDimen.MARGIN_MEDIUM),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.dark_purple.withOpacity(0.5),
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 1.0), // shadow direction: bottom right
                  )
                ],
              ),
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
                          color: AppTheme.black.withOpacity(0.5),
                        ),
                        hintText: "Enter comment here ...",
                        contentPadding: EdgeInsets.all(
                          AppDimen.MARGIN_CARD_MEDIUM_2,
                        ),
                        fillColor: Colors.transparent,
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
                      primary: AppTheme.dark_purple.withOpacity(0.4),
                      onPrimary: AppTheme.dark_purple.withOpacity(0.4),
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

class CommentListSectionView extends StatelessWidget {
  const CommentListSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FunProvider>(
      builder: (context, provider, child) => SliverList(
          delegate: SliverChildListDelegate(
        provider.commentListDao!.commentList!
            .map(
              (comment) => CommentItemWidget(
                name: comment.userNickName??"",
                profileUrl:  comment.profileUrl??"",
                commentText: comment.comment??"",
                duration: comment.commentAt??"",
              ),
            )
            .toList(),
      )),
    );
  }
}

class PostDetailSectionView extends StatelessWidget {
  final FunItem postItem;

  const PostDetailSectionView(
    this.postItem, {
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
                children: [
                  PostProfileUI(
                    profileUrl: 'assets/images/girl_light.png',
                    color: AppTheme.dark_purple,
                    name: postItem.userNickName ?? "",
                    duration: postItem.postUploadedAt ?? "",
                  ),
                  SizedBox(
                    height: AppDimen.MARGIN_MEDIUM_2,
                  ),
                  Text(
                    postItem.content ?? "",
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
                    commentCount: postItem.commentCount ?? "",
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