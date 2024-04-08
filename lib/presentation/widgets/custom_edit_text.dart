import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class CustomEditText extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final bool obscureText;
  final TextStyle? textStyle;
  final Function validator;
  final Color? defaultBorderSideColor;
  final Color? focusedBorderSideColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool? readOnly;
  final Function? onTap;
  final TextInputType? textInputType;

  CustomEditText({
    required this.label,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.textStyle,
    required this.validator,
    this.defaultBorderSideColor,
    this.focusedBorderSideColor,
    this.textInputType,
    this.width,
    this.height,
    this.margin = const EdgeInsets.symmetric(horizontal: 30),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Container(
        margin: margin,
        width: width,
        height: height,
        child: TextFormField(
          onTap: () {
            if(!(onTap == null)){
              onTap!();
            }
          },
          readOnly: readOnly!,
          obscureText: obscureText,
          style: textStyle,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: focusedBorderSideColor!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: defaultBorderSideColor!),
            ),

            labelText: label,
            prefixIcon: Icon(icon, ),
          ),
          validator: (_) => validator(_),
          controller: controller,
          keyboardType: textInputType,
        ),
      ),
    );
  }
}
