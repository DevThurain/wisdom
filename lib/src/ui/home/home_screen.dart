import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/dialog_utils.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/app_utils/user_profile_generator.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';
import 'package:wisdom/src/ui/add_post/fun_post_upload_screen.dart';
import 'package:wisdom/src/ui/auth/auth_screen.dart';
import 'package:wisdom/src/ui/fun/fun_list_screen.dart';
import 'package:wisdom/src/ui/knowledge/knowledge_list_screen.dart';
import 'package:wisdom/src/ui/profile/profile_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/top_gradient.dart';
import 'package:wisdom/src/view_models/ad_state.dart';
import 'package:wisdom/src/view_models/home_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeProvider = locator<HomeProvider>();
  var sharePreference = locator<SharedPreferenceHelper>();
  late BannerAd banner;
  bool _bannerLoaded = false;

  @override
  void initState() {
    super.initState();
    checkAppUpdateVersion();
    homeProvider.getUserProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AdState adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      banner = BannerAd(
          adUnitId: adState.bannerAdUnitId(),
          size: AdSize.banner,
          listener: BannerAdListener(
            onAdOpened: (ad) => print('Ad open: ${ad.adUnitId}.'),
            onAdLoaded: (ad) {
              setState(() {
                _bannerLoaded = true;
              });
              print('Ad loaded: ${ad.adUnitId}.');
            },
            onAdClosed: (ad) => print('Ad closed: ${ad.adUnitId}.'),
            onAdFailedToLoad: (ad, error) =>
                print('Ad fail to load: ${ad.adUnitId}. $error'),
          ),
          request: AdRequest())
        ..load();
    });
  }

  void checkAppUpdateVersion() {
    homeProvider.checkAppVersion().then((value) {
      if (!homeProvider.isAlreadyUpdated) {
        showDialog(
            context: context,
            barrierDismissible: !homeProvider.isAlreadyUpdated,
            builder: (_) {
              homeProvider.show = false;
              return WillPopScope(
                onWillPop: () async => homeProvider.isAlreadyUpdated,
                child: ForceUpdateDialog(
                    title: "Update Available!",
                    descriptions:
                        "A new version is available for this app. You can update it from store or direct link.",
                    isForceUpdate: homeProvider.isForceUpdate,
                    onClickButton: () => print("update")),
              );
            });
      }
    });
  }

  _logoutUser() async {
    await sharePreference.clear();
    Navigator.pushReplacementNamed(context, AuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => homeProvider,
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        if (provider.logout) {
          _logoutUser();
        }

        return Scaffold(
          backgroundColor: AppTheme.white,
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 50,
                child: Stack(
                  children: [
                    //#gradient
                    TopGradient(),
                    //#endgradient
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: AppDimen.MARGIN_MEDIUM_2,
                                  right: AppDimen.MARGIN_MEDIUM_2,
                                  top: MediaQuery.of(context).padding.top +
                                      AppDimen.MARGIN_MEDIUM_2,
                                  bottom: AppDimen.MARGIN_MEDIUM_2,
                                ),
                                child: ProfileSectionView(
                                  onTap: () {
                                    _logoutUser();
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppDimen.MARGIN_MEDIUM_2,
                                  vertical: AppDimen.MARGIN_MEDIUM_2,
                                ),
                                child: TitleText(),
                              ),
                              SizedBox(height: 20),
                              DesignedCard(
                                title: 'Knowledge',
                                color: AppTheme.dark_purple,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, KnowledgeListScreen.routeName);
                                },
                              ),
                              SizedBox(height: 20),
                              DesignedCard(
                                title: 'Fun',
                                color: AppTheme.dark_purple,
                                onTap: () {
                                  Navigator.pushNamed(context, FunListScreen.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _bannerLoaded
                  ? SizedBox(
                      width: double.infinity, height: 50, child: AdWidget(ad: banner))
                  : SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}

class ProfileSectionView extends StatelessWidget {
  const ProfileSectionView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Text(
              AppLocalizations.of(context)!.home_logout,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.dark_purple,
                fontSize: AppDimen.TEXT_REGULAR,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: AppDimen.MARGIN_MEDIUM_3),
          InkWell(
            onTap: () => Navigator.pushNamed(context, ProfileScreen.routeName),

            child: CircularPersonFace(
              width: 20,
              imgPath: provider.userProfile??""
            ),
          )
        ],
      );
    });
  }

  Future<String> getUserProfile() async {
    int userId = await SharedPreferences.getInstance()
        .then((_pref) => _pref.getInt('PREF_USER_ID')!);

    return TempProfileGenerator.getTempProfileUrl(userId);
  }
}

class DesignedCard extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;

  const DesignedCard({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2),
      height: 150,
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
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.4,
                child: RotatedBox(
                  //4,1
                  quarterTurns: 4,
                  child: Image.asset(
                    'assets/images/curve_1.png',
                    color: AppTheme.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color,
                    fontSize: AppDimen.TEXT_REGULAR_3X,
                    fontFamily: 'Poppins',
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.appTitle.toUpperCase(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: AppTheme.dark_purple,
          fontSize: AppDimen.TEXT_REGULAR_3X,
          fontFamily: 'Poppins',
          letterSpacing: 3,
          fontWeight: FontWeight.bold),
    );
  }
}
