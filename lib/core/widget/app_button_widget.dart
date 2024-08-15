import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'AppTextWidget.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    super.key,
    required this.onPressed,
    this.btnName = "Button",
    this.txtColor = AppColors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.padding,
    this.isEnable = true,
    this.isLoading = false,
    this.child,
    this.textAlign = TextAlign.center,
    this.border,
    this.btnColor,
    this.height,
    this.width,
    this.borderRadius,
    this.loaderColor = AppColors.white
  });
  final double? height;
  final double? width;
  final Function() onPressed;
  final String btnName;
  final Color txtColor;
  final Color loaderColor;
  final Color? btnColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets? padding;
  final TextAlign textAlign;
  final Widget? child;
  final bool isEnable;
  final bool isLoading;
  final Border? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable && !isLoading ? onPressed : null,
      child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
              border: border,
              color: btnColor,
              borderRadius: borderRadius ?? BorderRadius.circular(20),
              gradient: btnColor == null
                  ? LinearGradient(
                      // stops: const [0,1],
                      colors: [
                          AppColors.primaryColor,
                          AppColors.primaryColor.withOpacity(0.5),
                        ])
                  : null,
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: AppColors.black25)
              ]),
          child: isLoading
              ? SizedBox(
                  height: fontSize + 5,
                  width: fontSize + 5,
                  child:  CircularProgressIndicator(
                    color: loaderColor ,
                    strokeWidth: 3,
                  ))
              : child ??
                  AppTextWidget(
                    txtTitle: btnName,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    txtColor: isEnable ? txtColor : txtColor.withOpacity(0.4),
                  )),
    );
  }
}
