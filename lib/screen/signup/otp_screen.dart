import 'dart:async';

import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/forms/app_pin_text_field.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late Timer? handler = null;
  final int waitTimeInSeconds = 59;
  late int waitTime;
  bool showTimer = false;
  FormGroup form = FormGroup({
    'pin': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(5),
    ])
  });

  @override
  void initState() {
    waitTime = waitTimeInSeconds;
    super.initState();
  }

  @override
  void dispose() {
    if (Utils.isNotNull(handler)) {
      handler?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
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
                  height: Utils.getScreen(context).height * .03,
                ),
                Row(children: [
                  Expanded(
                    child: AutoSizeText(
                      'It’s OTP time! ',
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ]),
                SizedBox(
                  height: Utils.getScreen(context).height * .01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'We have sent an OTP to the given phone number',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        widget.phoneNumber,
                        textAlign: TextAlign.center,
                        textScaleFactor: 2,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppPinTextField(
                        formControlName: 'pin',
                        buildContext: context,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                showTimer
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: Resources.primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          AutoSizeText(
                            formatTime(waitTime),
                            textScaleFactor: 1.2,
                            style:
                                const TextStyle(color: Resources.primaryColor),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _startTimer();
                                showTimer = true;
                                setState(() {});
                              },
                              child: const AutoSizeText(
                                'Resend',
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Resources.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
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
                            formControlName: 'pin',
                            builder: (context, control, child) => AppButton(
                              onTap: () {
                                form.markAllAsTouched();
                                if (form.valid) {
                                  Navigator.pushNamedAndRemoveUntil(context, Routes.welcomeOnboardScreen,(route) => false);
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

  void _startTimer() {
    handler = Timer.periodic(const Duration(seconds: 1), (timer) {
      waitTime = waitTime - 1;
      if (waitTime < 0) {
        handler?.cancel();
        waitTime = waitTimeInSeconds;
        showTimer = false;
      }
      setState(() {});
    });
  }

  String formatTime(int count) {
    if (count < 10) {
      return '00:0' + count.toString();
    }
    return '00:' + count.toString();
  }
}
