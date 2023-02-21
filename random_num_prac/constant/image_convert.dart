import 'package:flutter/material.dart';

class imageConvert extends StatelessWidget {
  int numConvert;
  imageConvert({required this.numConvert, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: numConvert
          .toString()
          .split('')
          .map(
            (x) => Image.asset(
              'assets/img/$x.png',
              height: 70,
              width: 50,
            ),
          )
          .toList(),
    );
  }
}
