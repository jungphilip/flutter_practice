import 'package:flutter/material.dart';
import 'package:u_and_i/screen/record_screen.dart';
import 'package:u_and_i/widgets/bottom_navigation_bar.dart';

class AnniversaryScreen extends StatefulWidget {
  final DateTime selectedDate;
  const AnniversaryScreen({
    super.key,
    required this.selectedDate,
  });

  @override
  State<AnniversaryScreen> createState() => _AnniversaryScreenState();
}

class _AnniversaryScreenState extends State<AnniversaryScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _anniversaryDate = DateTime.now();
  int diff = 0;
  int i = 1;
  int index2 = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = widget.selectedDate;
    diff = DateTime.now().difference(_selectedDate).inDays;
  }

  void _onHomeTap() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _onRecordTap() async {
    final result = await Navigator.of(context).push<DateTime>(
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          selectedDate: _selectedDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: ListView.separated(
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (BuildContext, index) {
          _anniversaryDate = DateTime(
            _selectedDate.year + i,
            _selectedDate.month,
            _selectedDate.day,
          );
          if (index2 * 100 <=
                  _anniversaryDate.difference(_selectedDate).inDays &&
              _anniversaryDate.difference(_selectedDate).inDays <=
                  (index2 + 1) * 100) {
            i++;
            return anniversaryMark(
              anniversary: true,
              i: i,
              selectedDate: _anniversaryDate,
            );
          } else {
            index2++;
            return anniversaryMark(
              anniversary: false,
              i: index2,
              selectedDate:
                  _selectedDate.add(Duration(days: (index2 * 100 - 1))),
            );
          }
        },
      ),
      bottomNavigationBar: BottomBar(
        onAnniversaryTap: () {},
        onHomeTap: _onHomeTap,
        onRecordTap: _onRecordTap,
      ),
    );
  }
}

class anniversaryMark extends StatelessWidget {
  int? i;
  DateTime selectedDate;
  bool anniversary;
  anniversaryMark({
    required this.selectedDate,
    required this.anniversary,
    this.i,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            anniversary
                ? Expanded(
                    child: Text(
                      '${i! - 1}주년',
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          fontFamily: 'sunflower'),
                    ),
                  )
                : Expanded(
                    child: Text(
                      '${i! * 100}일',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontFamily: 'sunflower'),
                    ),
                  ),
            Expanded(
              child: Text(
                selectedDate.toString().split(" ")[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'sunflower',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
