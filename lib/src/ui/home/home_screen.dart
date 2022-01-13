import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/dialog_utils.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';
import 'package:wisdom/src/ui/add_post/add_post_screen.dart';
import 'package:wisdom/src/ui/auth/auth_screen.dart';
import 'package:wisdom/src/ui/fun/fun_list_screen.dart';
import 'package:wisdom/src/ui/knowledge/knowledge_screen.dart';
import 'package:wisdom/src/ui/profile/profile_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
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

  @override
  void initState() {
    homeProvider.checkAppVersion();
    super.initState();
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
        //ToDo - Add "!" after testing at !provider.isAlreadyUpdated
        if (!provider.isAlreadyUpdated) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            showDialog(
                context: context,
                barrierDismissible: !provider.isAlreadyUpdated,
                builder: (_) {
                  return WillPopScope(
                    onWillPop: () async => provider.isAlreadyUpdated,
                    child: CustomDialogBox(
                        title: "Update Available!",
                        descriptions:
                            "A new version is available for this app. You can update it from store or direct link.",
                        isForceUpdate: provider.isForceUpdate,
                        onClickButton: () => print("update")),
                  );
                });
          });
        }

        if (provider.logout) {
          _logoutUser();
        }

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
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(AppDimen.MARGIN_MEDIUM_2),
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
                    Navigator.pushNamed(context, KnowledgeScreen.routeName);
                  },
                ),
                SizedBox(height: 20),
                DesignedCard(
                  title: 'Fun',
                  color: AppTheme.dark_purple,
                  onTap: () {
                    Navigator.pushNamed(context, FunListScreen.routeName);
                  },
                )
              ],
            ),
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
            imgPath: 'assets/images/girl_light.png',
          ),
        )
      ],
    );
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
