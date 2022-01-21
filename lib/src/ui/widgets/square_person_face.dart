import 'package:flutter/material.dart';

class SquarePersonFace extends StatelessWidget {
  final double width;
  final String? imgPath;

  SquarePersonFace({Key? key, this.width = 40, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imgPath != null)
        ? Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: Color(0xffb7b7f5),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                  image: AssetImage(imgPath!), fit: BoxFit.cover),
            ),
          )
        : Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: Color(0xffb7b7f5),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          );
  }
}
