import 'package:flutter/material.dart';
import 'package:u_and_i/screen/anniversary_screen.dart';
import 'package:u_and_i/screen/record_screen.dart';
import 'package:u_and_i/widgets/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  DateTime? result;
  SplashScreen({this.result, super.key});

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
    await Navigator.of(context).push<DateTime>(
      MaterialPageRoute(
        builder: (context) => AnniversaryScreen(
          selectedDate: selectedDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: _TopPart(context),
      bottomNavigationBar: BottomBar(
        onAnniversaryTap: _onAnniversaryTap,
        onRecordTap: _onRecordTap,
        onHomeTap: () {},
      ),
    );
  }

  SafeArea _TopPart(BuildContext context) {
    return SafeArea(
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
                      const Text(
                        '우리가 함께한지',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'sunflower',
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "$dDay일",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'sunflower',
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(
                'asset/img/middle_image.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
