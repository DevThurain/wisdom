import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/vos/post_list_vo.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/widget_comment_item.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';

class FunDetailScreen extends StatefulWidget {
  static const routeName = '/post_detail_screen';
  final FunItem funItem;

  const FunDetailScreen(this.funItem, {Key? key}) : super(key: key);

  @override
  _FunDetailScreenState createState() => _FunDetailScreenState();
}

class _FunDetailScreenState extends State<FunDetailScreen> {
  var funProvider = locator<FunProvider>();
  TextEditingController commentBoxController = TextEditingController();

  double get _statusBarHeight {
    return MediaQuery.of(context).padding.top;
  }

  FunItem get _postItem {
    return widget.funItem;
  }



  @override
  void initState() {
    funProvider.getFunCommentListByPostId(postId: _postItem.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, funProvider.commentList!.length);
        return true;
      },
      child: ChangeNotifierProvider(
        create: (context) => funProvider,
        child: Consumer<FunProvider>(
          builder: (context, provider, child) => Scaffold(
            body: Stack(
              children: [
                NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      PostDetailHeader(_postItem),
                      SliverToBoxAdapter(
                        child: PostDetailSectionView(_postItem,
                            commentCount: funProvider.commentList!.isEmpty
                                ? _postItem.commentCount!
                                : funProvider.commentList!.length),
                      ),
                    ];
                  },
                  body: Container(
                    color: Colors.white,
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(top: AppDimen.MARGIN_MEDIUM_2),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              provider.commentList!
                                  .map(
                                    (comment) => CommentItemWidget(
                                      name: comment.creator!.nickname ?? "",
                                      profileUrl:
                                          comment.creator!.profileAssetsUrl ?? "",
                                      commentText: comment.comment ?? "",
                                      duration: comment.date ?? "",
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            bottom: AppDimen.MARGIN_XXLARGE * 2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimen.MARGIN_MEDIUM),
                        topRight: Radius.circular(AppDimen.MARGIN_MEDIUM),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.dark_purple.withOpacity(0.5),
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset:
                              Offset(0, 1.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: TextField(
                            controller: commentBoxController,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                fontSize: AppDimen.TEXT_REGULAR_2X,
                                fontFamily: 'MyanUni',
                                letterSpacing: 0.5,
                                color: AppTheme.black.withOpacity(0.5),
                              ),
                              hintText: "Add a comment ...",
                              contentPadding: EdgeInsets.all(
                                AppDimen.MARGIN_CARD_MEDIUM_2,
                              ),
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () => sendComment(commentBoxController),
                          constraints: BoxConstraints(),
                          elevation: 0,
                          fillColor: Colors.white,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          splashColor: Color(0xffb7b7f5).withOpacity(0.5),
                          highlightColor: Color(0xffb7b7f5).withOpacity(0.5),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return ui.Gradient.linear(
                                Offset(4.0, 24.0),
                                Offset(24.0, 4.0),
                                [Colors.deepPurple, Color(0xffb7b7f5)],
                              );
                            },
                            child: Icon(
                              Icons.send,
                              size: 24.0,
                            ),
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendComment(TextEditingController commentBoxController) {
    if (commentBoxController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Type something in comment box.");
    } else {
      funProvider.addComment(_postItem.id!, commentBoxController.text);
      commentBoxController.clear();
    }
  }
}

class PostDetailHeader extends StatelessWidget {
  final FunItem postItem;

  const PostDetailHeader(this.postItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      collapsedHeight: 65,
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      flexibleSpace: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
              Color(0xffb7b7f5),
              Color(0xffe7e7f8),
              AppTheme.white,
            ])),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_LARGE),
          child: PostProfileUI(
            profileUrl: postItem.creator!.profileAssetsUrl,
            color: AppTheme.dark_purple,
            name: postItem.creator!.nickname ?? "",
            duration: postItem.date ?? "",
          ),
        ),
      ),
    );
  }
}

class PostDetailSectionView extends StatelessWidget {
  final FunItem postItem;
  final int? commentCount;

  const PostDetailSectionView(
    this.postItem, {
    this.commentCount = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.MARGIN_LARGE,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppDimen.MARGIN_MEDIUM_2,
            ),
            Text(
              postItem.post ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: AppDimen.TEXT_REGULAR_2X,
                fontFamily: 'MyanUni',
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(
              height: AppDimen.MARGIN_MEDIUM,
            ),
            Container(
              height: 0.5,
              color: Color(0xffb7b7f5).withOpacity(0.3),
            ),
            SizedBox(
              height: AppDimen.MARGIN_MEDIUM,
            ),
            PostCommentUI(
              commentCount: "$commentCount",
            ),
          ],
        ),
      ),
    );
  }
}
