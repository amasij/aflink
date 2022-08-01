
import 'package:aflink/custom_widgets/forms/shared.dart';
import 'package:aflink/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppDropDownField<T> extends ReactiveDropdownField<T> {
  AppDropDownField({Key? key,
    required String formControlName,
    required List<DropdownMenuItem<T>> items,
    bool isSecondary = false,
    required String hintText,
    Map<String, String> validationMessages = const {},
    required void Function(T?) onChange,
  }) : super(key: key,
            formControlName: formControlName,
            items: items,
            validationMessages: (e) {
              return {}..addAll(validationMessages);
            },
            onChanged: onChange,
//            style: TextStyle(color: Colors.white),
            decoration: inputDecoration.copyWith(
                hintText: hintText,
                fillColor: isSecondary
                    ? Resources.primaryColor
                    : Colors.white));
}
