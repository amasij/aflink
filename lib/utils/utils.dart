import 'package:flutter/cupertino.dart';

class Utils {
  static Size getScreen(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static bool isNotNull(dynamic obj) {
    return obj != null;
  }

  static bool isNull(dynamic obj) {
    return !Utils.isNotNull(obj);
  }
}
