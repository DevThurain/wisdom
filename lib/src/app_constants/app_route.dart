import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';
import 'package:wisdom/src/data_models/vos/knowledge_list_vo.dart';
import 'package:wisdom/src/data_source/shared_pref/share_pref_helper.dart';
import 'package:wisdom/src/ui/add_post/fun_post_upload_screen.dart';
import 'package:wisdom/src/ui/add_post/knowledge_post_upload_screen.dart';
import 'package:wisdom/src/ui/auth/auth_screen.dart';
import 'package:wisdom/src/ui/fun/fun_detail_screen.dart';
import 'package:wisdom/src/ui/fun/fun_list_screen.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/intro/intro_screen.dart';
import 'package:wisdom/src/ui/knowledge/knowledge_detail_screen.dart';
import 'package:wisdom/src/ui/knowledge/knowledge_list_screen.dart';
import 'package:wisdom/src/ui/profile/profile_screen.dart';

class AppRoute {

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {

    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case HomeScreen.routeName:
            return const HomeScreen();

          case KnowledgeListScreen.routeName:
            return const KnowledgeListScreen();

          case FunListScreen.routeName:
            return const FunListScreen();

          case ProfileScreen.routeName:
            return const ProfileScreen();

          case IntroScreen.routeName:
            return const IntroScreen();

          case FunDetailScreen.routeName:
            return FunDetailScreen(routeSettings.arguments as FunItem);

          case KnowledgeDetailScreen.routeName:
            return KnowledgeDetailScreen(
                routeSettings.arguments as KnowledgeItem);

          case FunPostUploadScreen.routeName:
            return const FunPostUploadScreen();

          case KnowledgePostUploadScreen.routeName:
            return const KnowledgePostUploadScreen();

          case AuthScreen.routeName:
            return const AuthScreen();

          default:
            return const IntroScreen();
        }
      },
    );
  }
}

Future<bool> checkTokenStored() async {
  var _pref = await SharedPreferences.getInstance();
  String token = _pref.getString(PREF_AUTH_TOKEN) ?? '';
  return token.isNotEmpty;
}
