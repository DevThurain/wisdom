import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class SquarePersonFace extends StatelessWidget {
  final double width;
  final String imgPath;

  SquarePersonFace({required this.width, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(image: AssetImage(imgPath), fit: BoxFit.cover)),
    );
  }
}
