import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/di.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widget/app_text_button_widget.dart';

class SendOtpButton extends ConsumerStatefulWidget {
  const SendOtpButton({
    required this.getPhone,
    required this.timerOn,
    super.key,
    required this.enable,
  });
  final String Function() getPhone;
  final void Function(bool) timerOn;
  final bool enable;
  @override
  ConsumerState<SendOtpButton> createState() => _SendOtpButtonState();
}

class _SendOtpButtonState extends ConsumerState<SendOtpButton> {
  bool showResend = false;
  bool showTimer = false;
  Timer? timer;
  int countDown = 60;
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    widget.timerOn(true);
    timer?.cancel();
    countDown = 60;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      countDown--;
      if (countDown == 0) {
        timer?.cancel();
        showResend = true;
        showTimer = false;
        widget.timerOn(false);
      }
      setState(() {});
    });
  }

  Future<void> sendOtp() async {
    final phone = widget.getPhone();
    final sent = await ref.read(loginController.notifier).sendOtp(
          phone,
        );
    if (sent) {
      showTimer = true;
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !ref.watch(loginController).isLoading,
      replacement: const Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12, right: 15),
          child: CircularProgressIndicator()),
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 14, right: 10),
        child: AppTextButtonWidget(
          textAlign: TextAlign.right,
          onPressed: () {
            if (!showTimer) {
              sendOtp();
            }
          },
          fontSize: 12,
          fontWeight: FontWeight.w600,
          isEnable: widget.enable,
          btnName: showTimer
              ? "$countDown"
              : showResend
                  ? "RESEND OTP"
                  : "SEND OTP",
          txtColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
