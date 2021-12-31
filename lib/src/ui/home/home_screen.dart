import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/src/app_utils/locator.dart';
import 'package:wisdom/src/view_models/home_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeProvider = locator<HomeProvider>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => homeProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Consumer<HomeProvider>(
            builder: (ctx, homeProvider, child) {
              return homeProvider.versionStatus.isEmpty
                  ? Text('version loading')
                  : Text(homeProvider.versionStatus);
            },
          ),
        ),
      ),
    );
  }
}
