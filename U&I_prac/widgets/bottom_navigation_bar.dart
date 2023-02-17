import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final void Function()? onRecordTap;
  final void Function()? onAnniversaryTap;
  final void Function()? onHomeTap;

  const BottomBar(
      {this.onAnniversaryTap, this.onHomeTap, this.onRecordTap, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.pink[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onRecordTap,
            icon: const Icon(Icons.edit_calendar),
          ),
          IconButton(
            onPressed: onHomeTap,
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: onAnniversaryTap,
            icon: const Icon(Icons.checklist_rtl),
          ),
        ],
      ),
    );
  }
}
