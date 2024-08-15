import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AppTextWidget.dart';

import '../styles/app_colors.dart';

/*
Changes (14-7-2022) (Mustafa): Interchanged suffix icon and suffix widget
 */
class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      this.onChanged,
      required this.hintText,
      this.obscureText = false,
      this.suffixWidget,
      this.controller,
      this.focusNode,
      this.validator,
      this.suffixStyle,
      this.suffixIcon,
      this.autoFocus = false,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.words,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.inputFormatters,
      this.keyboardType,
      this.prefixIcon,
      this.readOnly = false,
      this.maxLength,
      this.contentPadding,
      this.initialValue,
      this.border,
      this.labelText,
      this.enabled,
      this.maxLines = 1});

  final Function(dynamic val)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final Function(String val)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool autoFocus;
  final Widget? suffixWidget;
  final Widget? suffixIcon;
  final TextStyle? suffixStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final bool readOnly;
  final int? maxLines;
  final EdgeInsets? contentPadding;
  final String? initialValue;
  final BorderSide? border;
  final String? labelText;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      initialValue: initialValue,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      autofocus: autoFocus,
      cursorColor: AppColors.primaryColor,
      maxLength: maxLength,

      // style: const TextStyle(
      //   color: AppColors.black,
      //   fontSize: 14,
      //   fontWeight: FontWeight.w400,
      // ),
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      readOnly: readOnly,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(

        label: labelText == null
            ? null
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: AppTextWidget(
                  txtTitle: labelText,
                  txtColor: AppColors.charcoalBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
        floatingLabelBehavior: FloatingLabelBehavior.always,

        counterText: "",
        errorStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.errorColor),
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        isDense: true,
        suffix: suffixWidget, // previously it was suffixIcon
        suffixIcon: suffixIcon, // previously it was suffixWidget
        suffixStyle: suffixStyle,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: AppColors.hintText,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        fillColor: AppColors.white,
        iconColor: AppColors.primaryColor,
        enabled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            gapPadding: 0,
            borderSide: border ?? BorderSide.none),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            gapPadding: 0,
            borderSide: border ?? BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            gapPadding: 0,
            borderSide: border ?? BorderSide.none),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
