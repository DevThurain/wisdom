import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/dialog_utils.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/ui/add_post/add_post_screen.dart';
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

  @override
  void initState() {
    homeProvider.checkVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => homeProvider,
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
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
                        descriptions: "A new version is available for this app. You can install it from store and direct link.",
                        titleImage: "",
                        isForceUpdate: provider.isForceUpdate,
                        onClickButton: () => print("update")),
                  );
                });
          });
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
                  child: ProfileSectionView(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimen.MARGIN_MEDIUM_2,
                      vertical: AppDimen.MARGIN_MEDIUM_2),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppLocalizations.of(context)!.home_logout,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppTheme.dark_purple,
              fontSize: AppDimen.TEXT_REGULAR,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal),
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
