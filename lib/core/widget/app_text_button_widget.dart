import 'package:flutter/material.dart';
import 'AppTextWidget.dart';

import '../styles/app_colors.dart';

class AppTextButtonWidget extends StatelessWidget {
  const AppTextButtonWidget({
    super.key,
    required this.onPressed,
     this.textAlign,
    this.btnName = "Button",
    this.txtColor = AppColors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.isEnable = true,
    this.decoration = TextDecoration.none
  });
  final Function() onPressed;
  final String btnName;
  final Color txtColor;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isEnable;
  final TextDecoration decoration;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: isEnable ? onPressed : null,
        child: 
                AppTextWidget(
                  textAlign: textAlign??TextAlign.left,
                  txtTitle: btnName,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  txtColor: isEnable? txtColor : txtColor.withOpacity(0.5),
                  decoration: decoration,
                ));
  }
}
