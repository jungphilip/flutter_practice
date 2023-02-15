import 'package:flutter/material.dart';
import 'package:u_and_i/screen/anniversary_screen.dart';
import 'package:u_and_i/screen/record_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int dDay = 1;
  DateTime selectedDate = DateTime.now();
  void _onRecordTap() async {
    final result = await Navigator.of(context).push<DateTime>(
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          selectedDate: selectedDate,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        dDay = DateTime.now().difference(result).inDays + 1;
        selectedDate = result;
      });
    }
  }

  void _onAnniversaryTap() async {
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'U&I',
                      style: TextStyle(
                        fontFamily: 'parisieene',
                        fontSize: 80,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[200],
                          ),
                          onPressed: () {
                            _onRecordTap();
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
                            _onAnniversaryTap();
                          },
                          child: const Text(
                            '기념일 확인하기',
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "D+$dDay",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'sunflower',
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'asset/img/middle_image.png',
                  width: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
