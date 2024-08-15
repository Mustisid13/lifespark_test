
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    this.txtTitle = "",
    this.txtColor = AppColors.primaryColor,
    this.fontWeight = FontWeight.w600,
    this.fontStyle = FontStyle.normal,
    this.fontSize = 14,
    this.maxLine = 5,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
    this.fontFamily,
    this.letterSpacing, this.height,
  });

  final String? txtTitle;
  final Color txtColor;
  final FontWeight fontWeight;

  // String fontFamily = AppTheme.robotoRegular,
  final FontStyle fontStyle;
  final double fontSize;
  final int maxLine;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final TextDecoration decoration;
  final String? fontFamily;
  final double? letterSpacing;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      txtTitle??"N/A",
      maxLines: maxLine,
      
      style: TextStyle(
        color: txtColor,
        height: height == null? 1: height!/fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontSize: fontSize,
        decoration: decoration,
        decorationColor: txtColor,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
      ),
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
