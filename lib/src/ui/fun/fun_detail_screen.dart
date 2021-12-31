import 'package:flutter/material.dart';

class FunDetailScreen extends StatefulWidget {
  static const routeName = '/fun_detail_screen';

  const FunDetailScreen({Key? key}) : super(key: key);

  @override
  _FunDetailScreenState createState() => _FunDetailScreenState();
}

class _FunDetailScreenState extends State<FunDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fun Detail'),
      ),
    );
  }
}
