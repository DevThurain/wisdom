import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';

class KnowledgeScreen extends StatefulWidget {
  static const routeName = '/knowledge_screen';
  const KnowledgeScreen({Key? key}) : super(key: key);

  @override
  _KnowledgeScreenState createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  late ScrollController _scrollController;
  bool expanded = false;
  KnowlegeProvider knowlegeProvider = locator<KnowlegeProvider>();

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_isAppBarExpanded) {
          setState(() {
            expanded = true;
          });
          print('expanded');
        } else {
          setState(() {
            expanded = false;
          });
          print('not expanded');
        }
      });

    super.initState();
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > 100;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KnowlegeProvider>(
      create: (context) => knowlegeProvider,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildSliverAppBar(),
            Consumer<KnowlegeProvider>(
              builder: (context, provider, child) {
                _scrollController.addListener(() {
                  if (_scrollController.offset ==
                          _scrollController.position.maxScrollExtent &&
                      !provider.paginateLock) {
                    provider.paginateLock = true;
                    provider.fetchPaginatedList();
                  }
                });

                return SliverList(
                    delegate: SliverChildListDelegate(
                  provider.facts
                      .map((post) => DesignedPostCard(
                          title: post.fact.toString(),
                          profileUrl: 'assets/images/girl_light.png',
                          name: 'Chrono',
                          duration: '2 hours ago',
                          commentCount: '12',
                          color: AppTheme.dark_purple,
                          onTap: () {}))
                      .toList(),
                ));
              },
            )
          ],
        ),
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
          padding: EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_CARD_MEDIUM_2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !expanded,
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
                    'Daily feed',
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
              ProfileSectionView(),
            ],
          ),
        ),
      ),
      backgroundColor: AppTheme.white,
    );
  }
}

class ProfileSectionView extends StatelessWidget {
  const ProfileSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(seconds: 2),
      tween: Tween<double>(begin: 0.0, end: 16.0),
      builder: (_, double value, __) => Row(
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
          CircularPersonFace(
            width: 20,
            imgPath: 'assets/images/girl_light.png',
          )
        ],
      ),
    );
  }
}
