import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/forms/app_text_field.dart';
import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({Key? key}) : super(key: key);

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  bool formValid = false;
  FormGroup form = FormGroup({
    'username': FormControl<String>(
        value: '', validators: [Validators.required, Validators.minLength(2)]),
    'email': FormControl<String>(
        value: '', validators: [Validators.required, Validators.email]),
    'firstName':
        FormControl<String>(value: '', validators: [Validators.required]),
    'lastName':
        FormControl<String>(value: '', validators: [Validators.required]),
    'password': FormControl<String>(
        value: '', validators: [Validators.required, Validators.minLength(8)]),
  });

  @override
  void initState() {
    form.valueChanges.listen((event) {
      // print(form.valid)
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
      appBar: signUpAppBar(canGoBack: true, step: 2, context: context),
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
                  height: Utils.getScreen(context).height * .06,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: AutoSizeText(
                        'Please enter your basic information below?',
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
                      child: AutoSizeText(
                        'This information is stored securely on AfLink',
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
                      child: AppTextField(
                          formControlName: 'firstName',
                          hintText: 'First Name',
                          validationMessages: const {
                            ValidationMessage.required:
                                'First name is required',
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AppTextField(
                          formControlName: 'lastName',
                          hintText: 'Last Name',
                          validationMessages: const {
                            ValidationMessage.required: 'Last name is required',
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .035,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                          formControlName: 'username',
                          hintText: 'Username',
                          validationMessages: const {
                            ValidationMessage.minLength:
                                "Can't be less than 2 characters",
                            ValidationMessage.required: 'Username is required',
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .035,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                          formControlName: 'email',
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validationMessages: const {
                            ValidationMessage.email:
                                'Looks like an invalid email',
                            ValidationMessage.required: 'Email is required',
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .035,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                          formControlName: 'password',
                          hintText: 'Password',
                          obscureText: true,
                          validationMessages: const {
                            ValidationMessage.minLength:
                                'Too short. Minimum of 8 characters',
                            ValidationMessage.required: 'Password is required',
                          }),
                    ),
                  ],
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
                                    context, Routes.dateOfBirthScreen);
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
