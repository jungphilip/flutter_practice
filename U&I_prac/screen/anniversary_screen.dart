import 'package:flutter/material.dart';
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
  int diff = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = widget.selectedDate;
    diff = DateTime.now().difference(_selectedDate).inDays;
  }

  void _onHomeTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: ListView.builder(
        itemBuilder: (BuildContext, int) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: Colors.black,
                  )),
                ),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Center(child: Text(_selectedDate.toString())),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomBar(
        onAnniversaryTap: () {},
        onHomeTap: _onHomeTap,
        onRecordTap: () {},
      ),
    );
  }
}
