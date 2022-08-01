import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/forms/app_checkbox_field.dart';
import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({Key? key}) : super(key: key);

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  FormGroup form = FormGroup({
    'gender': FormControl<String>(value: '', validators: [Validators.required]),
    'displayGender': FormControl<bool>(
      value: false,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signUpAppBar(canGoBack: false, step: 1),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: true,
        child: ReactiveForm(
          formGroup: form,
          child: Container(
            padding: Resources.contentPadding,
            child: Column(
              children: [
                SizedBox(
                  height: Utils.getScreen(context).height * .03,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: AutoSizeText(
                        'How would you like to be identified?',
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
                  height: Utils.getScreen(context).height * .1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Please select your gender',
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey[700]),
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
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ReactiveValueListenableBuilder<String>(
                        formControlName: 'gender',
                        builder: (context, control, child) {
                          return _makeGenderButton(
                              label: 'MALE',
                              icon: Icons.male,
                              selected: control.value == 'MALE');
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: ReactiveValueListenableBuilder<String>(
                        formControlName: 'gender',
                        builder: (context, control, child) {
                          return _makeGenderButton(
                              label: 'FEMALE',
                              icon: Icons.female,
                              selected: control.value == 'FEMALE');
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .1,
                ),
                IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppCheckBoxField(
                          formControlName: 'displayGender',
                          label: 'Display my gender on my profile',
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: ReactiveValueListenableBuilder<String>(
                            formControlName: 'gender',
                            builder: (context, control, child) => AppButton(
                              onTap: () {
                                form.markAllAsTouched();
                                if (form.valid) {
                                  Navigator.pushNamed(
                                      context, Routes.usernameScreen);
                                }
                              },
                              enabled: control.valid,
                              label: 'CONTINUE',
                            ),
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

  Widget _makeGenderButton(
      {required String label, required IconData icon, required bool selected}) {
    return GestureDetector(
      onTap: () {
        form.control('gender').value = label;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Resources.primaryColor),
          borderRadius: BorderRadius.circular(25),
          gradient: selected
              ? const LinearGradient(
                  colors: [
                    Resources.primaryColor,
                    Resources.secondaryColor,
                  ],
                )
              : const LinearGradient(colors: [Colors.white, Colors.white]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: selected ? Colors.white : Resources.primaryColor,
            ),
            const SizedBox(
              width: 5,
            ),
            AutoSizeText(
              label,
              textScaleFactor: 1.4,
              style: TextStyle(
                  color: selected ? Colors.white : Resources.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
