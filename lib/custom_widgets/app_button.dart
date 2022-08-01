import 'package:aflink/resources/resources.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final bool enabled;

  const AppButton(
      {Key? key,
      required this.onTap,
      required this.label,
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
            gradient: enabled
                ? const LinearGradient(colors: [
                    Resources.primaryColor,
                    Resources.secondaryColor,
                  ])
                : const LinearGradient(colors: [Colors.grey, Colors.grey]),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: .8,
                  blurRadius: 1)
            ]),
        child: Text(
          label,
          textAlign: TextAlign.center,
          textScaleFactor: 1.2,
          style: TextStyle(
              color: enabled ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
