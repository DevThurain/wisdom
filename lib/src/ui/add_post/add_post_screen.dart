import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add_post_screen';
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  double get _statusBarHeight {
    return MediaQuery.of(context).padding.top;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            margin: EdgeInsets.only(top: _statusBarHeight),
            child: CustomScrollView(
              slivers: const [
               SliverToBoxAdapter(child:  AddPostSectionView()),
              ],
            ),
          ),
         
    );
  }
}


class AddPostSectionView extends StatelessWidget {
  const AddPostSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.dark_purple.withOpacity(0.1),
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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:  EdgeInsets.all(AppDimen.MARGIN_LARGE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  PostProfileUI(
                    profileUrl: 'assets/images/girl_light.png',
                    color: AppTheme.dark_purple,
                    name: "Ma Ma",
                    duration: "2 Hrs Ago",
                  ),
                  SizedBox(
                    height: AppDimen.MARGIN_MEDIUM_2,
                  ),
                  TextField(
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'What is in your mind'
                    ),
            
                    style: TextStyle(
                      fontSize: AppDimen.TEXT_REGULAR_2X,
                      fontFamily: 'MyanUni',
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: AppDimen.MARGIN_MEDIUM_2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        Container(
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: AppTheme.fresh_purple,
                          ),
                          child: Center(
                            child : Text('Post',
                            style: TextStyle(
                              color: AppTheme.white
                            ),)
                          ),
                        )
                    ],
                  )
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}