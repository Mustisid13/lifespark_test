import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lifespark_test/core/di/di.dart';
import 'package:lifespark_test/core/styles/app_colors.dart';
import 'package:lifespark_test/core/styles/debouncer.dart';
import 'package:lifespark_test/core/utils/extensions/strings_extension.dart';
import 'package:lifespark_test/core/widget/app_button_widget.dart';

import '../../../core/utils/app_validators.dart';
import '../../../core/widget/app_text_form_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    ValueNotifier<bool> valid = useState(false);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(homeController.notifier).showToastOfEmail();
      });

      email.addListener(() {
        Debouncer().run(() {
          valid.value = email.text.isValidEmail;
        });
      });

      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.charcoalBlack,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(loginController.notifier).logOut(context);
                
              },
              icon: const Icon(Icons.logout,color: AppColors.white,))
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextFormField(
              controller: email,
              textCapitalization: TextCapitalization.none,
              hintText: "Email*",
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.validateEmail,
            ),
            const Gap(50),
            AppButtonWidget(
              width: 200,
              isEnable: valid.value,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onPressed: () {
                ref.read(homeController.notifier).storeEmail(email.text);
                email.clear();
              },
              btnName: "SAVE EMAIL",
            )
          ],
        ),
      ),
    );
  }
}
