import 'package:flutter/material.dart';


class KnowledgeDetailScreen extends StatefulWidget {
    static const routeName = '/knowledge_detail_screen';

  const KnowledgeDetailScreen({ Key? key }) : super(key: key);

  @override
  _KnowledgeDetailScreenState createState() => _KnowledgeDetailScreenState();
}

class _KnowledgeDetailScreenState extends State<KnowledgeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge Detail'),
      ),
    );
  }
}