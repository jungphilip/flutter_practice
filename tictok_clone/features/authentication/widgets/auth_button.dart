import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/sizes.dart';
import '../username_screen.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final String? functionName;
  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    this.functionName,
  });

  void tapFunc(BuildContext context, String functionName) {
    if (functionName == 'Email') {
      Navigator.of(context).push(
        MaterialPageRoute(
          //
          builder: (context) => const UsernameScreen(),
        ),
      );
    } else if (functionName == 'Apple') {
    } else if (functionName == 'Facebook') {
    } else if (functionName == 'Google') {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tapFunc(context,
          functionName!), // onTap은 함수를 받아야 하는데 나는 void를 받아놓고 왜 안되지 하고 있었군..
      child: FractionallySizedBox(
        //얘의 부모는 현재 column, widthFactor로 부모 사이즈를 기준으로 상대적인 사이즈 지정
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size14,
            horizontal: Sizes.size14,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
