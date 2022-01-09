import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.width = double.infinity,
    required this.onChanged,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final double width;
  final Function(String) onChanged;
  final String hint;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        textInputAction: textInputAction,
        keyboardType: textInputType,
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
            fillColor: AppTheme.white,
            filled: true,
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: AppTheme.black.withOpacity(0.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}