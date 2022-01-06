import 'package:flutter/material.dart';
import 'package:wisdom/src/ui/widgets/gradient_background.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          GradientBackground(),
        ],
      ),
    );
  }
}
