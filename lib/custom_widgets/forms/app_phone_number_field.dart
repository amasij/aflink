import 'package:aflink/custom_widgets/forms/shared.dart';
import 'package:aflink/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppPhoneNumberField extends ReactiveFormField<String, String> {
  AppPhoneNumberField({
    Key? key,
    required String formControlName,
  }) : super(
            key: key,
            formControlName: formControlName,
            builder: (ReactiveFormFieldState<String, String> field) {

              FormControl control = field.control;
              return Column(
                children: [
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      field.didChange(number.phoneNumber);
                    },
                    onInputValidated: (bool value) {},
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    textFieldController: TextEditingController(),
                    formatInput: false,
                    inputDecoration: inputDecoration,
                    cursorColor: Resources.primaryColor,
                    searchBoxDecoration: inputDecoration.copyWith(
                      hintStyle: const TextStyle(color: Colors.black),
                      labelText: 'Country Name or code',
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Resources.primaryColor, width: 2.0),
                    ),
                    onSaved: (PhoneNumber number) {},
                  ),
                  control.invalid && control.touched && control.dirty
                      ? const Text(
                          'Required',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox.shrink()
                ],
              );
            });

  @override
  ReactiveFormFieldState<String, String> createState() =>
      ReactiveFormFieldState<String, String>();
}
