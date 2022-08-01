import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:aflink/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppPinTextField extends ReactiveFormField<String, String> {
  AppPinTextField({
    Key? key,
    required String formControlName,
    required BuildContext buildContext
  }) : super(
      key: key,
      formControlName: formControlName,
      builder: (ReactiveFormFieldState<String, String> field) {

        FormControl control = field.control;
        return PinCodeTextField(
          showCursor: true,
          cursorColor: Resources.primaryColor,
          pinTheme: PinTheme(
              inactiveColor: Colors.grey,
              activeColor: Resources.primaryColor,
              selectedColor: Colors.grey),
          onChanged: (String value) {
            field.didChange(value);
          },
          length: 5,
          appContext: buildContext,
        );
      });

  @override
  ReactiveFormFieldState<String, String> createState() =>
      ReactiveFormFieldState<String, String>();
}
