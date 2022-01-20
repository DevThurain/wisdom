import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class CircularPersonFace extends StatelessWidget {
  final double width;
  final String imgPath;

  CircularPersonFace({required this.width, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.white),
        color: Color(0xffb7b7f5),
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage(imgPath),
        backgroundColor: Colors.transparent,
        radius: width,
      ),
    );
  }
}
