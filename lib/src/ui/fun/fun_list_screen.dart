import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/ui/add_post/add_post_screen.dart';
import 'package:wisdom/src/ui/fun/fun_detail_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/top_gradient.dart';
import 'package:wisdom/src/ui/widgets/widget_footer_text.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';

class FunListScreen extends StatefulWidget {
  static const routeName = '/fun_list_screen';

  const FunListScreen({Key? key}) : super(key: key);

  @override
  _FunListScreenState createState() => _FunListScreenState();
}

class _FunListScreenState extends State<FunListScreen> {
  //late ScrollController _scrollController;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.dark_purple,
        onPressed: () {
          Navigator.pushNamed(context, AddPostScreen.routeName);
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
      expandedHeight: 160,
      collapsedHeight: 65,
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      flexibleSpace: Stack(
        children: [
          TopGradient(),
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(
                right: AppDimen.MARGIN_CARD_MEDIUM_2,
                left: AppDimen.MARGIN_CARD_MEDIUM_2,
                top: MediaQuery.of(context).padding.top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // Visibility(
                    //   //visible: !_isAppBarExpanded,
                    //   child: Text(
                    //     'Friday, January 16th',
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         color: Color(0xffAFAFBD),
                    //         fontSize: AppDimen.TEXT_REGULAR,
                    //         fontFamily: 'Poppins',
                    //         fontWeight: FontWeight.normal),
                    //   ),
                    // ),
                    Text(
                      'Fun feed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppTheme.dark_purple,
                          fontSize: AppDimen.TEXT_REGULAR_3X,
                          fontFamily: 'Poppins',
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CircularPersonFace(
                  width: 20,
                  imgPath: 'assets/images/girl_light.png',
                ),
              ],
            ),
          ),
        ],
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
                          .map((index, item) => MapEntry(
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/line_loading.json', width: 110),
          Text('Loading Posts',style: TextStyle(color: AppTheme.dark_purple,fontFamily: 'Poppins'),)
        ],
      );
    } else if (funProvider.state == ViewState.NO_INTERNET) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/no_internet.json', width: 110),
          Text('No Internet Connection!',style: TextStyle(color: AppTheme.dark_purple,fontFamily: 'Poppins'),)
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/app_error.json',width: 110),
          Text('Unknown Error',style: TextStyle(color: AppTheme.dark_purple,fontFamily: 'Poppins'),)
        ],
      );
    }
  }
}
