import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/forms/app_phone_number_field.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/utils/utils.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  FormGroup form = FormGroup({
    'phoneNumber': FormControl<String>(
        validators: [Validators.required,Validators.minLength(7)])
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        top: false,
        child: ReactiveForm(
          formGroup: form,
          child: Container(
            padding: Resources.contentPadding,
            child: Column(
              children: [
                SizedBox(
                  height: Utils.getScreen(context).height * .15,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Enter phone number to begin',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppPhoneNumberField(
                        formControlName: 'phoneNumber',
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .07,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: AutoSizeText(
                        'We will send you a text with a verification code.Data and Message rates may apply',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: ReactiveValueListenableBuilder<String>(
                            formControlName: 'phoneNumber',
                            builder: (context, control, child) {
                             return  AppButton(
                                onTap: () {
                                  form.markAllAsTouched();
                                  if (form.valid) {
                                    Navigator.pushNamed(context, Routes.otpScreen,
                                        arguments: control.value);
                                  }
                                },
                                enabled: control.valid,
                                label: 'CONTINUE',
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
