import 'package:flutter/material.dart';
import 'package:u_and_i/screen/anniversary_screen.dart';
import 'package:u_and_i/screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _onRecordTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void _onAnniversaryTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AnniversaryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              const Text(
                'U&I',
                style: TextStyle(
                  fontFamily: 'parisieene',
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 300,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[200],
                ),
                onPressed: () {
                  _onRecordTap(context);
                },
                child: const Text(
                  '기록하기',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[200],
                ),
                onPressed: () {
                  _onAnniversaryTap(context);
                },
                child: const Text(
                  '기념일 확인하기',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
