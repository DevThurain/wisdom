import 'package:flutter/material.dart';
import 'package:wisdom/src/ui/add_post/add_post_screen.dart';
import 'package:wisdom/src/ui/fun/fun_screen.dart';
import 'package:wisdom/src/ui/home/home_screen.dart';
import 'package:wisdom/src/ui/intro/intro_screen.dart';
import 'package:wisdom/src/ui/knowledge/knowledge_screen.dart';
import 'package:wisdom/src/ui/post_detail/post_detail_screen.dart';
import 'package:wisdom/src/ui/profile/profile_screen.dart';
import 'package:wisdom/src/ui/register/register_screen.dart';

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

          case FunScreen.routeName:
            return const FunScreen();

          case ProfileScreen.routeName:
            return const ProfileScreen();

          case IntroScreen.routeName:
            return const IntroScreen();

          case PostDetailScreen.routeName:
            return const PostDetailScreen();

          case AddPostScreen.routeName:
            return const AddPostScreen();

          case RegisterScreen.routeName:
            return const RegisterScreen();

          default:
            return const IntroScreen();
        }
      },
    );
  }
}
