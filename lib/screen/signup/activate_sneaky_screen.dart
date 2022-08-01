import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivateSneakyScreen extends StatefulWidget {
  const ActivateSneakyScreen({Key? key}) : super(key: key);

  @override
  State<ActivateSneakyScreen> createState() => _ActivateSneakyScreenState();
}

class _ActivateSneakyScreenState extends State<ActivateSneakyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signUpAppBar(canGoBack: true, step: 7, context: context),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          padding: Resources.contentPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Utils.getScreen(context).height * .03,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      const Expanded(
                        flex: 2,
                        child: AutoSizeText(
                          'Activate',
                          textScaleFactor: 1.7,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SvgPicture.asset(
                          'assets/svg/sneaky.svg',
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: Utils.getScreen(context).height * .03,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          'Activate one of Aflink’s coolest feature and make your search magical.',
                          textScaleFactor: 1.1,
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
                          'assets/svg/wand.svg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, Routes.uploadMediaScreen);
                          },
                          enabled: true,
                          label: 'ACTIVATE SNEAKY LINK',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Utils.getScreen(context).height * .03,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: () {},
                          label: 'NOT NOW',
                          transparent: true,
                          enabled: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
