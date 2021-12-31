import 'package:flutter/material.dart';

class KnowledgeScreen extends StatefulWidget {
  static const routeName = '/knowledge_screen';
  const KnowledgeScreen({Key? key}) : super(key: key);

  @override
  _KnowledgeScreenState createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge'),
      ),
    );
  }
}
