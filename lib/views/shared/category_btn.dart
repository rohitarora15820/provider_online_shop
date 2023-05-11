import 'package:flutter/material.dart';
import 'appstyle.dart';

class CategoryBtn extends StatelessWidget {
  final void Function()? onPress;
  final Color buttonClr;
  final String label;

  const CategoryBtn({
    Key? key,
    this.onPress,
    required this.buttonClr,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.240,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: buttonClr, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: Center(
          child: Text(
            label,
            style: appstyle(size: 16, color: buttonClr, fw: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
