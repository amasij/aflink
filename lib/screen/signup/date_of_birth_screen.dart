import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/forms/app_checkbox_field.dart';
import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class DateOfBirtScreen extends StatefulWidget {
  const DateOfBirtScreen({Key? key}) : super(key: key);

  @override
  State<DateOfBirtScreen> createState() => _DateOfBirtScreenState();
}

class _DateOfBirtScreenState extends State<DateOfBirtScreen> {
  DateTime lastDate = DateTime.now().subtract(
    const Duration(days: 6570),
  );
  FormGroup form = FormGroup({
    'dob': FormControl<DateTime>(validators: [Validators.required]),
    'displayAge': FormControl<bool>(value: false)
  });

@override
  void initState() {
    form.control('dob').value = lastDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signUpAppBar(canGoBack: true, step: 3, context: context),
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
                        'Tell us your birth day',
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
                  height: Utils.getScreen(context).height * .04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Let’s link you up with the perfect match.',
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .06,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReactiveValueListenableBuilder<DateTime>(
                        formControlName: 'dob',
                        builder: (context, control, child) {
                          return dp.DayPicker.single(
                            selectedDate: control.value ?? DateTime.now(),
                            lastDate: lastDate,
                            onChanged: (DateTime value) {
                              form.control('dob').value = value;
                            },
                            firstDate: DateTime(1960),
                            datePickerStyles: dp.DatePickerRangeStyles(
                                nextIcon: const Icon(
                                  Icons.chevron_right,
                                  color: Resources.primaryColor,
                                ),
                                prevIcon: const Icon(
                                  Icons.chevron_left,
                                  color: Resources.primaryColor,
                                ),
                                displayedPeriodTitle: const TextStyle(
                                  color: Resources.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                selectedDateStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                selectedSingleDateDecoration: BoxDecoration(
                                  color: Resources.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                currentDateStyle: const TextStyle(
                                    color: Resources.primaryColor)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppCheckBoxField(
                          formControlName: 'displayAge',
                          label: 'Display my age on my profile',
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
                          child: ReactiveValueListenableBuilder<DateTime>(
                            formControlName: 'dob',
                            builder: (context, control, child) => AppButton(
                              onTap: () {
                                form.markAllAsTouched();
                                if (form.valid) {
                                  Navigator.pushNamed(context, Routes.originScreen);
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
}
