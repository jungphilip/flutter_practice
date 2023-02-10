import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;
  const RouteOneScreen({
    super.key,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route one',
      children: [
        Text(
          'argumets : ${number.toString()}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: const Text('pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const RouteTwoScreen(),
                settings: const RouteSettings(arguments: 789),
              ),
            );
          },
          child: const Text('Push'),
        ),
      ],
    );
  }
}
