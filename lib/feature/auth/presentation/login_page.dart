import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lifespark_test/core/di/di.dart';
import 'package:lifespark_test/core/utils/app_validators.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../../core/styles/app_assets.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/widget/AppTextWidget.dart';
import '../../../core/widget/phone_number_field.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = useTextEditingController();
    final otp = useTextEditingController();
    ValueNotifier<bool> timerOn = useState(false);
    ValueNotifier<String> code = useState("+91");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Gap(50),
              Flexible(
                child: LottieBuilder.asset(AppAssets.welcome)),
                 Phonenumberfield(
                  controller: phoneNumber,
                  validator: AppValidators.validatePhoneNumber,
                  onCodeChange: (c) {
                    code.value = c;
                  }),
              const Gap(10),
              Consumer(builder: (context, ref, _) {
                return Pinput(
                  keyboardType: TextInputType.number,
                  length: 6,
                  preFilledWidget: const AppTextWidget(
                    txtTitle: "-",
                    txtColor: AppColors.hintText,
                    fontSize: 16,
                  ),
                  onCompleted: (value) async {
                    final result = await ref
                        .read(loginController.notifier)
                        .verifyOtp(otp.text, context);
                        if(!result){
                          otp.clear();
                        }
                  },
                  controller: otp,
                  defaultPinTheme: PinTheme(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.white),
                      height: 50,
                      width: 38),
                );
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
