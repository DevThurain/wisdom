import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';
import 'package:wisdom/src/data_models/vos/knowledge_list_vo.dart';
import 'package:wisdom/src/ui/add_post/fun_post_upload_screen.dart';
import 'package:wisdom/src/ui/add_post/knowledge_post_upload_screen.dart';
import 'package:wisdom/src/ui/fun/fun_detail_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/top_gradient.dart';
import 'package:wisdom/src/ui/widgets/widget_footer_text.dart';
import 'package:wisdom/src/view_models/ad_state.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';

import 'knowledge_detail_screen.dart';

class KnowledgeListScreen extends StatefulWidget {
  static const routeName = '/knowledge_list_screen';

  const KnowledgeListScreen({Key? key}) : super(key: key);

  @override
  _KnowledgeListScreenState createState() => _KnowledgeListScreenState();
}

class _KnowledgeListScreenState extends State<KnowledgeListScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  bool expanded = false;
  var knowledgeProvider = locator<KnowledgeProvider>();
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    knowledgeProvider.getKnowledgeList();
    super.initState();
  }

  void _loadInterstitialAd() {
    final AdState adState = Provider.of<AdState>(context);

    adState.initialization.then((status) {
      InterstitialAd.load(
        adUnitId: adState.interstitialAdUnitId(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            setState(() {
              _interstitialAd = ad;
              _isInterstitialAdReady = true;
            });
          },
          onAdFailedToLoad: (err) {
            setState(() {
              _isInterstitialAdReady = false;
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.dark_purple,
        onPressed: () async {
          KnowledgeItem knowledgeItem =
              await Navigator.pushNamed(context, KnowledgePostUploadScreen.routeName)
                  as KnowledgeItem;
          knowledgeProvider.updateKnowledgeList(knowledgeItem);
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

          if (!_isInterstitialAdReady) _loadInterstitialAd();

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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Knowledge feed',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTheme.dark_purple,
                    fontSize: AppDimen.TEXT_REGULAR_3X,
                    fontFamily: 'Poppins',
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.white,
    );
  }

  _moveToDetailScreen(Object? item) async {
    Navigator.pushNamed(
      context,
      KnowledgeDetailScreen.routeName,
      arguments: item,
    );
  }

  handlingWidget(KnowledgeProvider knowledgeProvider) {
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
          knowledgeProvider.refreshList(),
        },
        onLoading: () => {
          knowledgeProvider.getKnowledgeList(),
        },
        child: knowledgeProvider.knowledgeList!.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      knowledgeProvider.knowledgeList!
                          .asMap()
                          .map(
                            (index, item) => MapEntry(
                              index,
                              DesignedPostCard(
                                title: item.note.toString(),
                                profileUrl: item.creator!.profileAssetsUrl,
                                name: item.creator!.nickname ?? "",
                                duration: item.date ?? "",
                                commentCount: "No",
                                color: AppTheme.dark_purple,
                                onTap: () {
                                  if (_isInterstitialAdReady) {
                                    _interstitialAd?.fullScreenContentCallback =
                                        FullScreenContentCallback(
                                      onAdShowedFullScreenContent: (InterstitialAd ad) {
                                        setState(() {
                                          _isInterstitialAdReady = false;
                                        });
                                      },
                                      onAdDismissedFullScreenContent:
                                          (InterstitialAd ad) {
                                        _moveToDetailScreen(item);
                                        ad.dispose();
                                      },
                                      onAdFailedToShowFullScreenContent:
                                          (InterstitialAd ad, AdError error) {
                                        print(
                                            '$ad onAdFailedToShowFullScreenContent: $error');
                                        ad.dispose();
                                      },
                                    );
                                    _interstitialAd?.show();

                                    //_moveToDetailScreen(provider, item);
                                  } else {
                                    print('ads not loaded');
                                    _moveToDetailScreen(item);
                                  }
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
                  child: Text("There is No Knowledge Feeds"),
                ),
              ),
      );
    } else if (knowledgeProvider.state == ViewState.LOADING) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/line_loading.json', width: 110),
          Text(
            'Loading Posts',
            style: TextStyle(color: AppTheme.dark_purple, fontFamily: 'Poppins'),
          )
        ],
      );
    } else if (knowledgeProvider.state == ViewState.NO_INTERNET) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/no_internet.json', width: 110),
          Text(
            'No Internet Connection!',
            style: TextStyle(color: AppTheme.dark_purple, fontFamily: 'Poppins'),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/app_error.json', width: 110),
          Text(
            'Unknown Error',
            style: TextStyle(color: AppTheme.dark_purple, fontFamily: 'Poppins'),
          )
        ],
      );
    }
  }
}
