import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lifespark_test/core/styles/app_colors.dart';
import 'package:lifespark_test/core/styles/debouncer.dart';
import 'package:lifespark_test/core/widget/AppTextWidget.dart';
import 'package:lifespark_test/core/widget/app_text_form_widget.dart';

import '../../feature/auth/presentation/widgets/send_otp_button.dart';

class Phonenumberfield extends HookWidget {
  const Phonenumberfield(
      {super.key,
      required this.controller,
      required this.validator,
      required this.onCodeChange});
  final TextEditingController controller;
  final String? Function(String) validator;
  final void Function(String) onCodeChange;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> fieldActive = useState(true);
    ValueNotifier<String> code = useState("+91");
    ValueNotifier<bool> valid = useState(false);

    useEffect(() {
      controller.addListener(
        () {
          Debouncer().run(() {
            valid.value = controller.text.length == 10;
          });
        },
      );
      return () {};
    }, []);
    return AppTextFormField(
      enabled: fieldActive.value,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      controller: controller,
      suffixIcon: SendOtpButton(
          enable: valid.value,
          getPhone: () => code.value + controller.text,
          timerOn: (value) {
            fieldActive.value = !value;
          }),
      hintText: "Phone Number*",
      prefixIcon: InkWell(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode:
                  true, // optional. Shows phone code before the country name.
              onSelect: (Country country) {
                code.value = "+${country.phoneCode}";
                onCodeChange(code.value);
              },
            );
          },
          child: Container(
            width: 50,
            margin: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border:
                    Border(right: BorderSide(color: AppColors.charcoalBlack))),
            child: AppTextWidget(
              txtTitle: code.value,
              fontSize: 18,
              txtColor: AppColors.primaryColor,
            ),
          )),
    );
  }
}
