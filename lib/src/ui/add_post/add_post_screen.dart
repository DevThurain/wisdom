import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add_post_screen';
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
             decoration: BoxDecoration(
               color: AppTheme.dark_purple.withOpacity(0.001)
             ),
            child: CustomScrollView(
              slivers:  [
                _buildSliverAppBar(),
               SliverToBoxAdapter(child:  AddPostSectionView()),
              ],
            ),
          ),
         
    );
  }
}

SliverAppBar _buildSliverAppBar() {
  return SliverAppBar(
    expandedHeight: 65,
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
            Text(
              'Create Post',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.dark_purple,
                  fontSize: AppDimen.TEXT_REGULAR_3X,
                  fontFamily: 'Poppins',
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.withOpacity(0.1),
                minimumSize: Size.zero,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.MARGIN_MEDIUM_2,
                  vertical: AppDimen.MARGIN_SMALL,
                ),

                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Post",
                style: TextStyle(
                  fontSize: AppDimen.TEXT_REGULAR_2X,
                  fontFamily: 'MyanUni',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    backgroundColor: AppTheme.white,
  );
}

class AddPostSectionView extends StatelessWidget {
  const AddPostSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(AppDimen.MARGIN_CARD_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SquarePersonFace(width: 48, imgPath: 'assets/images/girl_light.png'),
              SizedBox(width: AppDimen.MARGIN_MEDIUM,),
              Text(
                'Ma Ma',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTheme.dark_purple,
                    fontSize: AppDimen.TEXT_REGULAR_2X,
                    fontFamily: 'Poppins',
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM,),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 1,
            autofocus: false,
            style: TextStyle(
              fontSize: AppDimen.TEXT_REGULAR_2X,
              fontFamily: 'MyanUni',
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(0.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(0.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              filled: true,
              hintStyle: TextStyle(
                fontSize: AppDimen.TEXT_REGULAR_3X,
                fontFamily: 'MyanUni',
                letterSpacing: 0.5,
                color: AppTheme.black.withOpacity(0.5),
              ),
              hintText: 'What is in your mind?',
              fillColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}