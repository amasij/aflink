import 'package:aflink/custom_widgets/app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aflink/custom_widgets/forms/app_dropdown_field.dart';
import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OriginScreen extends StatefulWidget {
  const OriginScreen({Key? key}) : super(key: key);

  @override
  State<OriginScreen> createState() => _OriginScreenState();
}

class _OriginScreenState extends State<OriginScreen> {
  FormGroup form = FormGroup({
    'country':
        FormControl<String>(value: '', validators: [Validators.required]),
    'state': FormControl<String>(value: '', validators: [Validators.required]),
    'city': FormControl<String>(value: '', validators: [Validators.required]),
  });

  bool formValid = false;

  @override
  void initState() {
    form.valueChanges.listen((event) {
      if (formValid != form.valid) {
        setState(() {
          formValid = form.valid;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signUpAppBar(canGoBack: true, step: 4, context: context),
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
                        'Where are you from?',
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
                  height: Utils.getScreen(context).height * .03,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'The perfect match could be closer than you think. ',
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
                    Expanded(
                      child: AppDropDownField<String>(
                        formControlName: 'country',
                        items: [
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/flags/ng.svg',
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Nigeria')
                              ],
                            ),
                            value: 'Nigeria',
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/flags/us.svg',
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('United States of America')
                              ],
                            ),
                            value: 'US',
                          ),
                        ],
                        hintText: 'Select Country',
                        onChange: (String? item) {},
                        validationMessages: const {
                          ValidationMessage.required:
                              'Please select your country'
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppDropDownField<String>(
                        formControlName: 'state',
                        items: const [
                          DropdownMenuItem(
                            child: Text('Abia State'),
                            value: 'Abia',
                          ),
                        ],
                        hintText: 'Select State',
                        onChange: (String? item) {},
                        validationMessages: const {
                          ValidationMessage.required:
                          'Please select a state'
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppDropDownField<String>(
                        formControlName: 'city',
                        items: const [
                          DropdownMenuItem(
                            child: Text('Wuse Zone 4'),
                            value: 'wuse',
                          ),
                        ],
                        hintText: 'Select City',
                        onChange: (String? item) {},
                        validationMessages: const {
                          ValidationMessage.required:
                          'Please select a city'
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .1,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onTap: () {
                              form.markAllAsTouched();
                              if (form.valid) {
                                Navigator.pushNamed(
                                    context, Routes.interestScreen);
                              }
                            },
                            enabled: formValid,
                            label: 'CONTINUE',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
