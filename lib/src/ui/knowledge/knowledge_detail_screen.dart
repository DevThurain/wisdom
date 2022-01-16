import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';
import 'package:wisdom/src/app_utils/hyper_text_view_util.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/data_models/vos/knowledge_list_vo.dart';
import 'package:wisdom/src/ui/widgets/designed_post_card.dart';
import 'package:wisdom/src/view_models/knowledge_provider.dart';

class KnowledgeDetailScreen extends StatefulWidget {
  static const routeName = '/knowledge_detail_screen';
  final KnowledgeItem knowledgeItem;

  const KnowledgeDetailScreen(this.knowledgeItem, {Key? key}) : super(key: key);

  @override
  _KnowledgeDetailScreenState createState() => _KnowledgeDetailScreenState();
}

class _KnowledgeDetailScreenState extends State<KnowledgeDetailScreen> {
  var knowledgeProvider = locator<KnowledgeProvider>();
  TextEditingController commentBoxController = TextEditingController();
  late ScrollController _nestedScrollController;

  KnowledgeItem get _postItem {
    return widget.knowledgeItem;
  }

  @override
  void initState() {
    _nestedScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => knowledgeProvider,
      child: Consumer<KnowledgeProvider>(
        builder: (context, provider, child) => Scaffold(
          body: Stack(
            children: [
              NestedScrollView(
                controller: _nestedScrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    PostDetailHeader(_postItem),
                    SliverToBoxAdapter(
                      child: Container(
                        color: AppTheme.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.MARGIN_LARGE,
                          ),
                          child:  SelectableText.rich(
                            TextSpan(
                              children: HyperTextViewUtil.extractText(_postItem.note ?? ""),
                              style: TextStyle(
                                fontSize: AppDimen.TEXT_REGULAR_2X,
                                fontFamily: 'MyanUni',
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostDetailHeader extends StatelessWidget {
  final KnowledgeItem postItem;

  const PostDetailHeader(this.postItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      collapsedHeight: 65,
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      flexibleSpace: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
              Color(0xffb7b7f5),
              Color(0xffe7e7f8),
              AppTheme.white,
            ])),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_LARGE),
          child: PostProfileUI(
            profileUrl: postItem.creator!.profileAssetsUrl,
            color: AppTheme.dark_purple,
            name: postItem.creator!.nickname ?? "",
            duration: postItem.date ?? "",
          ),
        ),
      ),
    );
  }
}
