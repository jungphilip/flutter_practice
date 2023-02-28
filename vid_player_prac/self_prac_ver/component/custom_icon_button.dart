import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icondata;

  const CustomIconButton(
      {required this.onPressed, required this.icondata, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30,
      color: Colors.white,
      icon: Icon(
        icondata,
      ),
    );
  }
}
