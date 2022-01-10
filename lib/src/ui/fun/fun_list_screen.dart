import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/ui/post_detail/post_detail_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
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
      flexibleSpace: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_CARD_MEDIUM_2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Visibility(
                    //visible: !_isAppBarExpanded,
                    child: Text(
                      'Friday, January 16th',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffAFAFBD),
                          fontSize: AppDimen.TEXT_REGULAR,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
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
        onLoading: () =>
        {
          funProvider.getFunList(currentPage: 2),
        },
        child: provider.funList!.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      provider.funList!
                          .map(
                            (item) => DesignedPostCard(
                              title: item.post.toString(),
                              profileUrl: item.creator!.code ?? "",
                              name: item.creator!.nickname ?? "",
                              duration: item.date ?? "",
                              commentCount: item.commentCount == null
                                  ? "No comment"
                                  : item.commentCount.toString(),
                              color: AppTheme.dark_purple,
                              onTap: () => Navigator.pushNamed(
                                context,
                                PostDetailScreen.routeName,
                                arguments: item,
                              ),
                            ),
                          )
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
