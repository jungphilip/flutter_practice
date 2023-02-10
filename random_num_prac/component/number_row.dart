import 'package:flutter/material.dart';

class NumberRow extends StatelessWidget {
  final int number;
  const NumberRow({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number
          .toString()
          .split('')
          .map(
            (x) => Image.asset(
              'assets/img/$x.png',
              width: 50,
              height: 70,
            ),
          )
          .toList(),
    );
  }
}
