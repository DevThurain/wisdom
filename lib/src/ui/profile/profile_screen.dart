import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/base_view_model.dart';
import 'package:wisdom/src/app_utils/dialog_utils/profile_update_dialog.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/response/response_user_profile_vo.dart';
import 'package:wisdom/src/ui/fun/fun_detail_screen.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';
import 'package:wisdom/src/ui/widgets/widget_footer_text.dart';
import 'package:wisdom/src/view_models/profile_provider.dart';

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
  var profileProvider = locator<ProfileProvider>();

  @override
  void initState() {
    profileProvider.getUserProfile();
    profileProvider.getMyFunList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (context) => profileProvider,
        child: Consumer<ProfileProvider>(builder: (context, provider, child) {
          if (_refreshController.isLoading) _refreshController.loadComplete();
          if (_refreshController.isRefresh) {
            _refreshController.refreshCompleted();
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildSliverAppBar(profileProvider.responseUserProfileVO),
              ];
            },
            // controller: _scrollController,
            body: handlingWidget(provider),
          );
        }),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(
      ResponseUserProfileVO? responseUserProfileVO) {
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
            name: responseUserProfileVO?.data?.nickname,
            profileUrl: responseUserProfileVO?.data?.profileUrl,
            userType: responseUserProfileVO?.data?.type,
            provider: profileProvider),
      ),
      backgroundColor: AppTheme.white,
    );
  }

  handlingWidget(ProfileProvider provider) {
    if (provider.state == ViewState.COMPLETE) {
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
          profileProvider.refreshList(),
        },
        onLoading: () => {
          profileProvider.getMyFunList(),
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
                                  profileProvider.currentSelectedFanId = index;
                                  int updatedCommentCount =
                                      await Navigator.pushNamed(
                                    context,
                                    FunDetailScreen.routeName,
                                    arguments: item,
                                  ) as int;

                                  profileProvider
                                      .updateCommentCount(updatedCommentCount);
                                },
                                deletePost: () => profileProvider.deletePost(
                                    postId: item.id!, position: index),
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
    } else if (provider.state == ViewState.LOADING) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/line_loading.json', width: 110),
          Text(
            'Loading Posts',
            style:
                TextStyle(color: AppTheme.dark_purple, fontFamily: 'Poppins'),
          )
        ],
      );
    } else if (provider.state == ViewState.NO_INTERNET) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/jsons/no_internet.json', width: 110),
          Text(
            'No Internet Connection!',
            style:
                TextStyle(color: AppTheme.dark_purple, fontFamily: 'Poppins'),
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
            style:
                TextStyle(color: AppTheme.dark_purple, fontFamily: 'Poppins'),
          )
        ],
      );
    }
  }

  Function? onTap() {
    print("AAA");
  }
}

class ProfileHeaderSectionView extends StatelessWidget {
  final Color? color;
  final String? name;
  final String? profileUrl;
  final String? userType;
  final ProfileProvider? provider;

  const ProfileHeaderSectionView({
    Key? key,
    this.color,
    this.name = "-",
    this.profileUrl,
    this.userType = "-",
    this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              SquarePersonFace(width: 40, imgPath: profileUrl ?? ""),
              SizedBox(width: AppDimen.MARGIN_MEDIUM),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name ?? "-",
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
                    userType ?? "-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffAFAFBD),
                        fontSize: AppDimen.TEXT_REGULAR,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            padding: EdgeInsets.all(0.0),
            color: color,
            icon: Icon(Icons.edit_rounded, size: 18.0),
            onPressed: () => showDialog(
              context: context,
              builder: (_) {
                return ProfileUpdateDialog(
                  title: "Update Profile",
                  profileProvider: provider,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
