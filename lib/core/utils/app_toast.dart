import 'package:flutter/material.dart';

import 'package:toastification/toastification.dart';

import '../styles/app_colors.dart';

Future<void> showToast({required String? title, bool isError = false}) async {
  toastification.dismissAll(delayForAnimation: false);
  toastification.show(
    
    type: ToastificationType.info,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(
      title ?? "Something went wrong!",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isError ? AppColors.white : AppColors.charcoalBlack),
    ),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },

    showIcon: true, // show or hide the icon
    primaryColor: isError
        ? AppColors.errorColor.withOpacity(0.5)
        : AppColors.secondaryColor,
    backgroundColor: isError
        ? AppColors.errorColor.withOpacity(0.9)
        : AppColors.secondaryColor,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: false,

    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
