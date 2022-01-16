import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';
import 'package:wisdom/src/ui/add_post/fun_post_upload_screen.dart';
import 'package:wisdom/src/ui/fun/fun_detail_screen.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';
import 'package:wisdom/src/ui/widgets/widget_footer_text.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile_screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool expanded = false;
  var funProvider = locator<FunProvider>();

  @override
  void initState() {
    funProvider.getFunList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.dark_purple,
        onPressed: () async {
          FunItem funItem =
              await Navigator.pushNamed(context, FunPostUploadScreen.routeName)
                  as FunItem;
          funProvider.updateFunList(funItem);
        },
        child: SvgPicture.asset(
          'assets/svgs/quil.svg',
          width: 28,
          color: AppTheme.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => funProvider,
        child: Consumer<FunProvider>(builder: (context, provider, child) {
          if (_refreshController.isLoading) _refreshController.loadComplete();
          if (_refreshController.isRefresh) {
            _refreshController.refreshCompleted();
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildSliverAppBar(),
              ];
            },
            // controller: _scrollController,
            body: handlingWidget(provider),
          );
        }),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      collapsedHeight: 65,
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
              Color(0xffb7b7f5),
              Color(0xffe7e7f8),
              AppTheme.white,
            ])),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: AppDimen.MARGIN_CARD_MEDIUM_2,
        ),
        child: ProfileHeaderSectionView(
          color: AppTheme.dark_purple,
          name: "Han Gyi",
          profileUrl: "assets/images/purple_minion.png",
        ),
      ),
      backgroundColor: AppTheme.white,
    );
  }

  handlingWidget(FunProvider provider) {
    if (funProvider.state == ViewState.COMPLETE) {
      return SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        header: CustomHeader(
          height: 24,
          builder: (context, mode) {
            return SizedBox(
              height: 18.0,
              child: Center(
                child: LoadingIndicator(
                  indicatorType: Indicator.lineSpinFadeLoader,
                  colors: const [AppTheme.dark_purple],
                ),
              ),
            );
          },
        ),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          height: 24,
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = FooterText(text: "pull up load");
            } else if (mode == LoadStatus.loading) {
              body = SizedBox(
                height: 18.0,
                child: Center(
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader,
                    colors: const [AppTheme.dark_purple],
                  ),
                ),
              );
            } else if (mode == LoadStatus.failed) {
              body = FooterText(text: "Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = FooterText(text: "release to load more");
            } else {
              body = FooterText(text: "No more Data");
            }
            return Center(
              child: SizedBox(
                height: 18,
                child: Center(child: body),
              ),
            );
          },
        ),
        onRefresh: () => {
          funProvider.getFunList(currentPage: 1),
        },
        onLoading: () => {
          funProvider.getFunList(currentPage: 2),
        },
        child: provider.funList!.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      provider.funList!
                          .asMap()
                          .map(
                            (index, item) => MapEntry(
                              index,
                              DesignedPostCard(
                                title: item.post.toString(),
                                profileUrl: item.creator!.profileAssetsUrl,
                                name: item.creator!.nickname ?? "",
                                duration: item.date ?? "",
                                commentCount: item.commentCount == null
                                    ? "No comment"
                                    : item.commentCount.toString(),
                                color: AppTheme.dark_purple,
                                onTap: () async {
                                  funProvider.currentSelectedFanId = index;
                                  int updatedCommentCount =
                                      await Navigator.pushNamed(
                                    context,
                                    FunDetailScreen.routeName,
                                    arguments: item,
                                  ) as int;

                                  funProvider
                                      .updateCommentCount(updatedCommentCount);
                                },
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ),
                ],
              )
            : Center(
                child: Container(
                  color: Colors.green,
                  child: Text("There is No Fun Feeds"),
                ),
              ),
      );
    } else if (funProvider.state == ViewState.LOADING) {
      return Container(
        color: Colors.amber,
        child: Text("Loading"),
      );
    } else if (funProvider.state == ViewState.NO_INTERNET) {
      return Container(
        color: Colors.brown,
        child: Text("No Internet"),
      );
    } else {
      return Container(
        color: Colors.red,
        child: Text("Error"),
      );
    }
  }
}

class ProfileHeaderSectionView extends StatelessWidget {
  final Color color;
  final String name;
  final String profileUrl;

  const ProfileHeaderSectionView({
    Key? key,
    required this.color,
    required this.name,
    required this.profileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
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
                    "Nick Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffAFAFBD),
                        fontSize: AppDimen.TEXT_REGULAR,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
        ),
        Align(
           alignment: Alignment.topRight,
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              color: color,
              icon: Icon(Icons.edit_rounded, size: 18.0),
              onPressed: () => showGeneralDialog(
                barrierDismissible: false,
                context: context,
                barrierColor: Colors.black54,
                transitionDuration: Duration(milliseconds: 600),
                transitionBuilder: (context, a1, a2, child) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: a1,
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.linearToEaseOut,
                    ),
                    child: CustomDialog(
                      // our custom dialog
                      title: "Chrono",
                      positiveBtnText: "Save",
                      negativeBtnText: "Close",
                      positiveBtnPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return SizedBox();
                },
              ),
            ))
      ],
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, positiveBtnText, negativeBtnText;
  final GestureTapCallback positiveBtnPressed;

  CustomDialog({
    Key? key,
    required this.title,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.positiveBtnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          // Bottom rectangular box
          margin: EdgeInsets.only(top: 40),
          // to push the box half way below circle
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppTheme.dark_purple,
                    fontSize: AppDimen.TEXT_HEADING_1X,
                    fontFamily: 'MyanUni',
                    height: 1,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
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
              ButtonBar(
                buttonMinWidth: 100,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(negativeBtnText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  FlatButton(
                    child: Text(positiveBtnText),
                    onPressed: positiveBtnPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(
          // Top Circle with icon
          maxRadius: 40.0,
          child: Icon(Icons.message),
        ),
        SquarePersonFace(
          width: 80,
          imgPath: 'assets/images/girl_light.png',
        ),
      ],
    );
  }
}
