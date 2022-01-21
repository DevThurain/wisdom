import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/ui/widgets/square_person_face.dart';
import 'package:wisdom/src/view_models/post_upload_provider.dart';

class FunPostUploadScreen extends StatefulWidget {
  static const routeName = '/add_fun_post_screen';

  const FunPostUploadScreen({Key? key}) : super(key: key);

  @override
  _FunPostUploadScreenState createState() => _FunPostUploadScreenState();
}

class _FunPostUploadScreenState extends State<FunPostUploadScreen> {
  var postUploadProvider = locator<PostUploadProvider>();
  TextEditingController postEditingController = TextEditingController();

  @override
  void initState() {
    postUploadProvider.getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => postUploadProvider,
        child: Consumer<PostUploadProvider>(
          builder: (context, provider, child) => Container(
            decoration:
                BoxDecoration(color: AppTheme.dark_purple.withOpacity(0.001)),
            child: CustomScrollView(
              slivers: [
                PostUploadHeader(
                  postEditingController,
                ),
                SliverToBoxAdapter(
                    child: AddPostSectionView(
                  provider.userName,
                  provider.userProfile,
                  postEditingController,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostUploadHeader extends StatefulWidget {
  final TextEditingController postEditingController;

  const PostUploadHeader(
    this.postEditingController, {
    Key? key,
  }) : super(key: key);

  @override
  _PostUploadHeaderState createState() => _PostUploadHeaderState();
}

class _PostUploadHeaderState extends State<PostUploadHeader> {

  var postUploadProvider = locator<PostUploadProvider>();


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 65,
      collapsedHeight: 65,
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      flexibleSpace: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: AppDimen.MARGIN_CARD_MEDIUM_2,
            right: AppDimen.MARGIN_CARD_MEDIUM_2),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
              Color(0xffb7b7f5),
              Color(0xffe7e7f8),
              AppTheme.white,
            ])),
        width: double.infinity,
        height: double.infinity,
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
              onPressed: () {
                FocusScope.of(context).unfocus();
                postUploadProvider
              .uploadFunPost(widget.postEditingController.text, context);},
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.dark_purple,
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
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.white,
    );
  }
}

class AddPostSectionView extends StatelessWidget {
  const AddPostSectionView(
    this.userName,
    this.userProfile,
    this.postEditingController, {
    Key? key,
  }) : super(key: key);
  final String userName;
  final String userProfile;
  final TextEditingController postEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimen.MARGIN_CARD_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SquarePersonFace(width: 38, imgPath: userProfile),
              SizedBox(
                width: AppDimen.MARGIN_MEDIUM,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Text(
                  userName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppTheme.dark_purple,
                      fontSize: AppDimen.TEXT_REGULAR_2X,
                      fontFamily: 'Poppins',
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM,),
          TextField(
            controller: postEditingController,
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
                fontSize: AppDimen.TEXT_REGULAR_2X,
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