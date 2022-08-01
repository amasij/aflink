import 'package:aflink/custom_widgets/forms/shared.dart';
import 'package:aflink/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppTextFieldSecondary extends ReactiveTextField {
  AppTextFieldSecondary({Key? key,
    required String formControlName,
    String hintText = '',
    int maxLines = 1,
    int? maxLength,
    Widget? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    Map<String, String> validationMessages = const {},
    bool obscureText = false,
  }) : super(key: key,
    style: const TextStyle(color: Colors.black),
    formControlName: formControlName,
    keyboardType: keyboardType,
    obscureText: obscureText,
    maxLines: maxLines,
    maxLength: maxLength,
    cursorColor: Resources.primaryColor,
    validationMessages: (e) {
      return {}
        ..addAll(globValidationMessages)
        ..addAll(validationMessages);
    },
    decoration: inputDecoration.copyWith(
        prefixIcon: prefixIcon,
        hintText: hintText, fillColor: Resources.primaryColor),
  );
}
