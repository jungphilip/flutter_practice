import 'package:flutter/material.dart';
import 'package:random_number/color/colors.dart';
import 'package:random_number/constant/image_convert.dart';

class SettingScreen extends StatefulWidget {
  double max;
  SettingScreen({required this.max, super.key});

  @override
  State<SettingScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: imageConvert(numConvert: widget.max.toInt())),
              Slider(
                value: widget.max,
                onChanged: (double value) {
                  widget.max = value;
                  setState(() {});
                },
                min: 1000,
                max: 100000,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(widget.max);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RED_COLOR,
                  ),
                  child: const Text('저장!')),
            ],
          ),
        ),
      ),
    );
  }
}
