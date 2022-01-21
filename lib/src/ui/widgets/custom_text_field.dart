import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.width = double.infinity,
    required this.onChanged,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final double width;
  final Function(String) onChanged;
  final String hint;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(28)),
      ),
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        obscureText: isPassword,
        keyboardType: textInputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(100),
        ],
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
            fillColor: AppTheme.white,
            filled: true,
            contentPadding: EdgeInsets.only(left: AppDimen.MARGIN_CARD_MEDIUM),
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
