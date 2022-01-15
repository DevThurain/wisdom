import 'package:flutter/material.dart';
import 'package:wisdom/src/app_constants/app_dimen.dart';
import 'package:wisdom/src/app_constants/app_theme.dart';

class CustomPasswordField extends StatefulWidget {
  CustomPasswordField({
    Key? key,
    this.width = double.infinity,
    required this.onChanged,
    required this.hint,
    required this.controller,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final double width;
  final Function(String) onChanged;
  final String hint;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  bool showPassword = false;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: TextField(
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            obscureText: widget.showPassword ? false : true,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
                fillColor: AppTheme.white,
                filled: true,
                contentPadding: EdgeInsets.only(left: AppDimen.MARGIN_CARD_MEDIUM),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppTheme.black.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                )),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              setState(() {
                widget.showPassword = !widget.showPassword;
              });
            },
            icon: widget.showPassword
                ? Icon(
                    Icons.visibility,
                    color: AppTheme.fresh_purple,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: AppTheme.black.withOpacity(0.5),
                  ),
          ),
        )
      ],
    );
  }
}
