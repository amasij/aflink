import 'package:aflink/resources/resources.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final bool enabled;
  final bool transparent;

  const AppButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.transparent = false,
      this.enabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: !enabled ? Colors.grey : Resources.primaryColor),
            gradient: _getBackgroundColor(),
            boxShadow: transparent
                ? []
                : [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: .8,
                        blurRadius: 1)
                  ]),
        child: Text(
          label,
          textAlign: TextAlign.center,
          textScaleFactor: 1.2,
          style:
              TextStyle(color: _getLabelColor(), fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Color? _getLabelColor() {
    if (enabled && (!transparent)) {
      return Colors.white;
    }
    if (enabled && transparent) {
      return Resources.primaryColor;
    }
    return Colors.grey[700];
  }

  LinearGradient _getBackgroundColor() {
    if (enabled && (!transparent)) {
      return const LinearGradient(colors: [
        Resources.primaryColor,
        Resources.secondaryColor,
      ]);
    }
    if (enabled && transparent) {
      return const LinearGradient(colors: [
        Colors.white,
        Colors.white,
      ]);
    }
    return LinearGradient(colors: [Colors.grey[300]!, Colors.grey[300]!]);
  }
}
