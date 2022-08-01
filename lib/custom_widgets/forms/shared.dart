import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:aflink/resources/resources.dart';

InputDecoration inputDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Resources.primaryColor, width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Resources.primaryColor, width: 1.0),
  ),
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Resources.primaryColor, width: 1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Resources.primaryColor, width: 1.0),
  ),
);

final Map<String, String> globValidationMessages = {
  ValidationMessage.required: 'This field is required',
  ValidationMessage.email: 'Invalid email',
  ValidationMessage.minLength: 'Too short',
  ValidationMessage.min: 'Too short',
  ValidationMessage.maxLength: 'Too long',
  ValidationMessage.max: 'Too long',
  'alreadyExists': 'Item already exists.'
};

Future<Map<String, dynamic>> Function(AbstractControl) validatePhoneFormat =
    (e) async {
  if (e.invalid) {
    e.markAsTouched();
    return e.errors;
  }
  e.markAsUntouched();
  if (e.value == null) return Future.value(null);
  if (e.value.length < 14) {
    e.markAsTouched();
    return <String, dynamic>{ValidationMessage.minLength: true};
  }
  if (e.value.length > 14) {
    e.markAsTouched();
    return <String, dynamic>{'maxLength': true};
  }
  try {
    return Future.value(null);
  } catch (ex) {
    print(ex);
    e.markAsTouched();
    return <String, dynamic>{'invalidFormat': true};
  }
};
