import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: const Text('CanPop'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: const Text('MaybePop'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const RouteOneScreen(number: 123),
                ),
              );

              print(result);
            },
            child: const Text('push'),
          )
        ],
      ),
    );
  }
}
