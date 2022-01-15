import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile_screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _scrollController;
  bool expanded = false;
  StickyHeaderController? _stickyHeaderController;
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
    return _scrollController.hasClients && _scrollController.offset > 168;
  }

  double get _statusBarHeight {
    return MediaQuery.of(context).padding.top;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: _statusBarHeight),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: _statusBarHeight),
                child: ProfileHeaderSectionView(
                    profileUrl: 'assets/images/girl_light.png',
                    name: 'Chrono',
                    color: AppTheme.dark_purple,
                    onTap: () {}),
              ),
            ),
            SliverStickyHeader(
              controller: _stickyHeaderController,
                header: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  color: !_isAppBarExpanded?Colors.transparent: Colors.white,
                  child: Text(
                    'Your Posts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppTheme.dark_purple,
                        fontSize: AppDimen.TEXT_REGULAR_3X,
                        fontFamily: 'Poppins',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                DesignedPostCard(
                    title:
                        "Jelly Eye Mask ပြန်ရပြီ\nPrice-3500 \nအရောင်ပုံ ရွေးမရပါ",
                    profileUrl: 'assets/images/girl_light.png',
                    name: 'Chrono',
                    duration: '2 hours ago',
                    commentCount: '12',
                    color: AppTheme.dark_purple,
                    onTap: () {}),
                DesignedPostCard(
                    title:
                        "ကျနော်လက်ရှိသုံးနေတဲ့ Budget Gaming PC လေးရောင်းချင်ပါတယ် AAA title game  တွေ အေးဆေးဆော့လို့ရပါတယ်",
                    profileUrl: 'assets/images/boy_light.png',
                    name: 'Dota God',
                    duration: '2 minutes ago',
                    commentCount: '4',
                    color: AppTheme.dark_purple,
                    onTap: () {}),
                DesignedPostCard(
                    title: "You have to be\nhuman to be played\nwith you",
                    profileUrl: 'assets/images/girl_light_2.png',
                    name: 'Ella',
                    duration: '2 hours ago',
                    commentCount: '12',
                    color: AppTheme.dark_purple,
                    onTap: () {}),
              ])),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileHeaderSectionView extends StatelessWidget {
  final Color color;
  final Function onTap;
  final String name;
  final String profileUrl;

  const ProfileHeaderSectionView({
    Key? key,
    required this.color,
    required this.onTap,
    required this.name,
    required this.profileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppDimen.MARGIN_MEDIUM_2,
          vertical: MediaQuery.of(context).size.height * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: color.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -150,
            bottom: 0,
            child: Opacity(
              opacity: 0.4,
              child: RotatedBox(
                //4,1
                quarterTurns: 3,
                child: Image.asset(
                  'assets/images/curve_1.png',
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
                height: 18.0,
                width: 18.0,
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  color: color,
                  icon: Icon(Icons.edit_rounded, size: 18.0),
                  onPressed: ()=> showGeneralDialog(
                    barrierDismissible: false,
                    context: context,
                    barrierColor: Colors.black54, // space around dialog
                    transitionDuration: Duration(milliseconds: 600),
                    transitionBuilder: (context, a1, a2, child) {
                      return ScaleTransition(
                        scale: CurvedAnimation(
                            parent: a1,
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.linearToEaseOut,
                        ),
                        child: CustomDialog( // our custom dialog
                          title: "Chrono",
                          positiveBtnText: "Save",
                          negativeBtnText: "Close",
                          positiveBtnPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                    pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {
                      return SizedBox();
                    },
                  ),
                )
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.MARGIN_MEDIUM_2,
                  vertical: AppDimen.MARGIN_MEDIUM_2),
              child: Row(
                children: [
                  SquarePersonFace(width: 60, imgPath: profileUrl),
                  SizedBox(width: AppDimen.MARGIN_MEDIUM),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: color,
                            fontSize: AppDimen.TEXT_HEADING_1X,
                            fontFamily: 'MyanUni',
                            height: 1,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Nick Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffAFAFBD),
                            fontSize: AppDimen.TEXT_REGULAR,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, positiveBtnText, negativeBtnText;
  final GestureTapCallback positiveBtnPressed;

  CustomDialog({Key? key,
    required this.title,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.positiveBtnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(  // Bottom rectangular box
          margin: EdgeInsets.only(top: 40), // to push the box half way below circle
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(top: 60, left: 20, right: 20), // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Text(
            title,
            textAlign: TextAlign.start,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppTheme.dark_purple,
                fontSize: AppDimen.TEXT_HEADING_1X,
                fontFamily: 'MyanUni',
                height: 1,
                fontWeight: FontWeight.normal),
          ),
              SizedBox(
                height: 16,
              ),
              TextField(
                autofocus: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                       Radius.circular(AppDimen.MARGIN_MEDIUM),
                    ),
                    borderSide: BorderSide(color: AppTheme.dark_purple.withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                       Radius.circular(AppDimen.MARGIN_MEDIUM),
                    ),
                    borderSide: BorderSide(color: AppTheme.dark_purple.withOpacity(0.3)),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color:  Color(0xffAFAFBD).withOpacity(
                      0.5,
                    ),
                    height: 1,
                  ),
                  hintText: "Enter Nick Name Here",
                  contentPadding: EdgeInsets.all(
                    AppDimen.MARGIN_CARD_MEDIUM_2,
                  ),
                  fillColor: AppTheme.white.withOpacity(0.2),
                ),
              ),
              ButtonBar(
                buttonMinWidth: 100,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(negativeBtnText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  FlatButton(
                    child: Text(positiveBtnText),
                    onPressed: positiveBtnPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar( // Top Circle with icon
          maxRadius: 40.0,
          child: Icon(Icons.message),
        ),
        SquarePersonFace(
          width: 80,
          imgPath: 'assets/images/girl_light.png',
        ),
      ],
    );
  }

}

