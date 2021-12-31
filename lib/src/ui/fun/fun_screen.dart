import 'package:flutter/material.dart';

class FunScreen extends StatefulWidget {
  static const routeName = '/fun_screen';
  const FunScreen({Key? key}) : super(key: key);

  @override
  _FunScreenState createState() => _FunScreenState();
}

class _FunScreenState extends State<FunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fun'),
      ),
    );
  }
}
