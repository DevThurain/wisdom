import 'package:flutter/material.dart';
import 'package:wisdom/src/data_models/daos/fun_list_dao.dart';
import 'package:wisdom/src/ui/fun/fun_list_screen.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/intro/intro_screen.dart';
import 'package:wisdom/src/ui/knowledge/knowledge_screen.dart';
import 'package:wisdom/src/ui/post_detail/post_detail_screen.dart';
import 'package:wisdom/src/ui/profile/profile_screen.dart';

class AppRoute {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case HomeScreen.routeName:
            return const HomeScreen();

          case KnowledgeScreen.routeName:
            return const KnowledgeScreen();

          case FunListScreen.routeName:
            return const FunListScreen();

          case ProfileScreen.routeName:
            return const ProfileScreen();

          case IntroScreen.routeName:
            return const IntroScreen();

          case PostDetailScreen.routeName:
            return  PostDetailScreen(routeSettings.arguments as FunItem);

          default:
            return const IntroScreen();
        }
      },
    );
  }
}
