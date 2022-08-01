import 'package:aflink/screen/signup/activate_sneaky_screen.dart';
import 'package:aflink/screen/signup/date_of_birth_screen.dart';
import 'package:aflink/screen/signup/gender_selection_screen.dart';
import 'package:aflink/screen/signup/interest_screen.dart';
import 'package:aflink/screen/signup/origin_screen.dart';
import 'package:aflink/screen/signup/otp_screen.dart';
import 'package:aflink/screen/signup/phone_number_screen.dart';
import 'package:aflink/screen/signup/upload_media_screen.dart';
import 'package:aflink/screen/signup/username_screen.dart';
import 'package:aflink/screen/signup/welcome_onboard_screen.dart';
import 'package:aflink/screen/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String welcomeScreen = '/welcome-screen';
  static const String phoneNumberScreen = '/phone-number-screen';
  static const String otpScreen = '/OTP-screen';
  static const String welcomeOnboardScreen = '/welcome-onboard-screen';
  static const String genderSelectionScreen = '/gender-selection-screen';
  static const String usernameScreen = '/username-screen';
  static const String dateOfBirthScreen = '/dob-screen';
  static const String originScreen = '/origin-screen';
  static const String interestScreen = '/interest-screen';
  static const String uploadMediaScreen = '/upload-media-screen';
  static const String activateSneakyLinkScreen = '/activate-sneaky-link-screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case phoneNumberScreen:
        return MaterialPageRoute(builder: (_) => const PhoneNumberScreen());
      case otpScreen:
        return MaterialPageRoute(
            builder: (_) =>
                OTPScreen(phoneNumber: (settings.arguments ?? '') as String));
      case welcomeOnboardScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeOnBoardScreen());
      case genderSelectionScreen:
        return MaterialPageRoute(builder: (_) => const GenderSelectionScreen());
      case usernameScreen:
        return MaterialPageRoute(builder: (_) => const UsernameScreen());
      case dateOfBirthScreen:
        return MaterialPageRoute(builder: (_) => const DateOfBirtScreen());
        case originScreen:
        return MaterialPageRoute(builder: (_) => const OriginScreen());
        case interestScreen:
        return MaterialPageRoute(builder: (_) => const InterestScreen());
        case uploadMediaScreen:
        return MaterialPageRoute(builder: (_) => const UploadMediaScreen());
        case activateSneakyLinkScreen:
        return MaterialPageRoute(builder: (_) => const ActivateSneakyScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
