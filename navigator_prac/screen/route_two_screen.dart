import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(
      title: 'Route Two',
      children: [
        Text('arguments: $arguments'),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: const Text('Push Named'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/three');
          },
          child: const Text('Push Replacement'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const RouteThreeScreen(),
              ),
              (route) => route.settings.name == '/',
            );
          },
          child: const Text('Push and Remove Until'),
        ),
        ElevatedButton(
          onPressed: () {
            print(Navigator.of(context).canPop());
          },
          child: const Text('CanPop'),
        ),
      ],
    );
  }
}
