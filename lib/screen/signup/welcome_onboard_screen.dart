import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WelcomeOnBoardScreen extends StatelessWidget {
  const WelcomeOnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          padding: Resources.contentPadding,
          child: Column(
            children: [
              SizedBox(
                height: Utils.getScreen(context).height * .1,
              ),
              Row(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/svg/logo.svg',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Utils.getScreen(context).height * .03,
              ),
              Row(
                children: const [
                  Expanded(
                    child: AutoSizeText(
                      'Welcome Onboard',
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
                height: Utils.getScreen(context).height * .02,
              ),
              Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      'Please agree and follow these terms',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.grey[700]),
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
                    child: SvgPicture.asset(
                      'assets/svg/icons/check.svg',
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: AutoSizeText(
                      'Make sure your profile information are correct and true to who you are.',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.grey[700]),
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
                    child: SvgPicture.asset(
                      'assets/svg/icons/favorite.svg',
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: AutoSizeText(
                      'Consider others and treat everyone as you would like to be treated.',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.grey[700]),
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
                    child: SvgPicture.asset(
                      'assets/svg/icons/report.svg',
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: AutoSizeText(
                      'Don’t share your personal information with total strangers. Stay safe.',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.grey[700]),
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
                    child: SvgPicture.asset(
                      'assets/svg/icons/flag.svg',
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: AutoSizeText(
                      'Flag inappropriate behavior or communication.',
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
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
                          label: 'I  AGREE',
                          enabled: true,
                          onTap: () {
                            Navigator.pushReplacementNamed(context, Routes.genderSelectionScreen);
                          },
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
}
