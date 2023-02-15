import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final DateTime selectedDate;
  const HomeScreen({
    super.key,
    required this.selectedDate,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Column(
          children: [
            _TopPart(
              selectedDate: _selectedDate,
              onPressed: onHeartPressed,
            ),
            _BottomPart(
              selectedDate: _selectedDate,
            ),
          ],
        ),
      ),
    );
  }

  onHeartPressed() {
    showCupertinoDialog(
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime time) {
                setState(() {
                  _selectedDate = time;
                });
              },
            ),
          ),
        );
      },
      context: context,
    );
  }
}

class _BottomPart extends StatelessWidget {
  DateTime selectedDate;

  _BottomPart({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  void _onSaveTap(BuildContext context) {
    Navigator.of(context).pop(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
            ),
            onPressed: () => _onSaveTap(context),
            child: const Text(
              '저장하기',
            ),
          ),
        ],
      ),
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const _TopPart({
    required this.selectedDate,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

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
              onPressed: onPressed,
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
