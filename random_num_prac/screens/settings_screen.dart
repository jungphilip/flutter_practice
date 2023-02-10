import 'package:flutter/material.dart';
import 'package:random_number/component/number_row.dart';
import 'package:random_number/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({
    super.key,
    required this.maxNumber,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

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
              _Body(maxNumber: maxNumber),
              _Footer(
                  maxNumber: maxNumber,
                  onSliderChagned: onSliderChanged,
                  onButtonPressed: onButtonPressed),
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    maxNumber = val;
    setState(() {});
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.maxNumber,
  }) : super(key: key);

  final double maxNumber;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSliderChagned;
  final VoidCallback onButtonPressed;
  const _Footer({
    Key? key,
    required this.maxNumber,
    required this.onSliderChagned,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
            value: maxNumber,
            min: 1000,
            max: 1000000,
            onChanged: onSliderChagned),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: RED_COLOR,
          ),
          onPressed: onButtonPressed,
          child: const Text('저장!'),
        ),
      ],
    );
  }
}
