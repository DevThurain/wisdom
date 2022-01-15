import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/ui/add_post/add_post_screen.dart';
import 'package:wisdom/src/ui/knowledge/knowledge_detail_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/widget_footer_text.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';

class KnowledgeListScreen extends StatefulWidget {
  static const routeName = '/knowledge_list_screen';

  const KnowledgeListScreen({Key? key}) : super(key: key);

  @override
  _KnowledgeListScreenState createState() => _KnowledgeListScreenState();
}

class _KnowledgeListScreenState extends State<KnowledgeListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool expanded = false;
  var knowledgeProvider = locator<KnowledgeProvider>();

  @override
  void initState() {
    knowledgeProvider.getKnowledgeList();
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
        create: (context) => knowledgeProvider,
        child: Consumer<KnowledgeProvider>(builder: (context, provider, child) {
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
                    'Knowledge feed',
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

  handlingWidget(KnowledgeProvider provider) {
    if (knowledgeProvider.state == ViewState.COMPLETE) {
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
          knowledgeProvider.getKnowledgeList(currentPage: 1),
        },
        onLoading: () => {
          knowledgeProvider.getKnowledgeList(currentPage: 2),
        },
        child: provider.knowledgeList!.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      provider.knowledgeList!
                          .asMap()
                          .map((index, item) => MapEntry(
                              index,
                              DesignedPostCard(
                                title: item.note.toString(),
                                profileUrl: item.creator!.profileAssetsUrl,
                                name: item.creator!.nickname ?? "",
                                duration: item.date ?? "",
                                color: AppTheme.dark_purple,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    KnowledgeDetailScreen.routeName,
                                    arguments: item,
                                  );
                                },
                                commentCount: 'remove',
                              )))
                          .values
                          .toList(),
                    ),
                  ),
                ],
              )
            : Center(
                child: Container(
                  color: Colors.green,
                  child: Text("There is No Knowledge Feeds"),
                ),
              ),
      );
    } else if (knowledgeProvider.state == ViewState.LOADING) {
      return Container(
        color: Colors.amber,
        child: Text("Loading"),
      );
    } else if (knowledgeProvider.state == ViewState.NO_INTERNET) {
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
