import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/ui/post_detail/post_detail_screen.dart';
import 'package:wisdom/src/ui/widgets/circular_person_face.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/view_models/fun_provider.dart';

class FunListScreen extends StatefulWidget {
  static const routeName = '/fun_list_screen';

  const FunListScreen({Key? key}) : super(key: key);

  @override
  _FunListScreenState createState() => _FunListScreenState();
}

class _FunListScreenState extends State<FunListScreen> {
  late ScrollController _scrollController;

  bool expanded = false;
  var funProvider = locator<FunProvider>();

  @override
  void initState() {
    funProvider.getFunList();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_isAppBarExpanded) {
          setState(() {
            expanded = true;
          });
        } else {
          setState(() {
            expanded = false;
          });
        }
      });

    super.initState();
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FunProvider>(
        builder: (context, provider, child) => CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildSliverAppBar(),
            SliverList(
                delegate: SliverChildListDelegate(
              provider.funListDao!.funList!
                  .map(
                    (post) => DesignedPostCard(
                      title: post.content.toString(),
                      profileUrl: post.profileUrl ?? "",
                      name: post.userNickName ?? "",
                      duration: post.postUploadedAt ?? "",
                      commentCount: post.commentCount ?? "",
                      color: AppTheme.dark_purple,
                      onTap: () => Navigator.pushNamed(
                        context,
                        PostDetailScreen.routeName,
                        arguments: post,
                      ),
                    ),
                  )
                  .toList(),
            )),
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
          padding:
              EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_CARD_MEDIUM_2),
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
}
