import 'package:flutter/material.dart';

import 'appstyle.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    Key? key,
    this.onTap,
    required this.label,
  }) : super(key: key);
  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: EdgeInsets.all(8 ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(child: Text(label,
        style: appstyle(size: 20, color: Colors.white, fw: FontWeight.bold),
        )),
      ),
      ),
    );
  }
}
