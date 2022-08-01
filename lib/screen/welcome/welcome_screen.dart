import 'package:aflink/constants/image_constants.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageConstant.welcomeBackground,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: Utils.getScreen(context).height * .135,
            left: Utils.getScreen(context).width * .3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstant.logoWhite,
                  height: 60,
                ),
              ],
            ),
          ),
          Positioned(
            top: Utils.getScreen(context).height * .35,
            child: SizedBox(
              width: Utils.getScreen(context).width * .9,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText(
                  'Find your perfect match and link up',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textScaleFactor: 3,
                  maxLines: 3,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Utils.getScreen(context).height * .09,
            width: Utils.getScreen(context).width,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 15),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.phoneNumberScreen);
                        },
                        child: const Text(
                          'CREATE ACCOUNT',
                          textScaleFactor: 1.2,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 15),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0x888d0b93)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'SIGN IN',
                          textScaleFactor: 1.2,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Trouble signing in ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
