import 'package:aflink/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

PreferredSizeWidget signUpAppBar({
  required bool canGoBack,
  required int step,
  BuildContext? context,
}) {
  return AppBar(
    automaticallyImplyLeading: canGoBack,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: canGoBack
        ? GestureDetector(
            onTap: () => Navigator.pop(context!),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          )
        : const SizedBox.shrink(),
    title: AutoSizeText(
      'Step 0$step of 07',
      textScaleFactor: .75,
      style: const TextStyle(
          color: Resources.primaryColor, fontWeight: FontWeight.bold),
    ),
  );
}
