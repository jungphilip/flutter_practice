import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _TopPart(),
            const _BottomPart(),
          ],
        ),
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Image.asset(
            'asset/img/middle_image.png',
            width: 200,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('저장하기'))
        ],
      ),
    );
  }
}

class _TopPart extends StatefulWidget {
  @override
  State<_TopPart> createState() => _TopPartState();
}

class _TopPartState extends State<_TopPart> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "U&I",
              style: TextStyle(
                fontFamily: 'parisieene',
                fontSize: 80,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                const Text(
                  "우리 처음 만난날",
                  style: TextStyle(
                    fontFamily: 'sunflower',
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  selectedDate.toString().split(" ")[0],
                  style: const TextStyle(
                    fontFamily: 'sunflower',
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            IconButton(
              iconSize: 60,
              onPressed: () {
                showCupertinoDialog(
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: 300,
                        child: CupertinoDatePicker(
                          initialDateTime: selectedDate,
                          maximumDate: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime time) {
                            setState(() {
                              selectedDate = time;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  context: context,
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            Text(
              'D+${DateTime.now().difference(selectedDate).inDays + 1}',
              style: const TextStyle(
                fontFamily: 'sunflower',
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
