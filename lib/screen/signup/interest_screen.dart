import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({Key? key}) : super(key: key);

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  Map<String, bool> interestControls = {};
  final List<String> selectedInterests = [];
  final List<String> interests = [
    'Hiding',
    'Reading',
    'Hiking',
    'Running',
    'Dinning',
    'Swimming',
    'Workout',
    'Dancing',
    'Singing',
    'Music',
    'Chatting',
    'Shopping',
    'Travelling',
    'Vlogging',
    'Editing',
    'Movies',
    'Football',
    'writing',
    'sports',
    'Acting'
  ];

  @override
  void initState() {
    interests.map((e) => interestControls[e] = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signUpAppBar(canGoBack: true, step: 5, context: context),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: true,
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
                      'Tell us about your Interest',
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
                      'Let the Aflink community know your interests from your profile ',
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
              Wrap(
                direction: Axis.horizontal,
                spacing: 15,
                runSpacing: 15,
                children: interests
                    .map(
                      (e) => _createPill(
                          label: e, selected: interestControls[e] ?? false),
                    )
                    .toList(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.uploadMediaScreen);
                          },
                          enabled: selectedInterests.isNotEmpty,
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
    );
  }

  Widget _createPill({required String label, required bool selected}) {
    return GestureDetector(
      onTap: () {
        interestControls[label] = !(interestControls[label] ?? false);
        if (interestControls[label] ?? false) {
          selectedInterests.add(label);
        } else {
          selectedInterests.remove(label);
        }
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: selected ? Resources.primaryColor : Colors.grey,
              width: 1.2),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: selected ? Resources.primaryColor : Colors.black),
        ),
      ),
    );
  }
}
