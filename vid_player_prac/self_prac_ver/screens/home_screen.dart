import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null ? renderVideo() : renderEmpty(),
    );
  }

  final ownstyle = const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w300,
  );

  renderEmpty() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            ontap: onNewVideoPressed,
          ),
          const SizedBox(
            height: 20,
          ),
          _Appname(ownstyle: ownstyle),
        ],
      ),
    );
  }

  renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        onCamera: onNewVideoPressed,
        video: video!,
      ),
    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }
}

class _Appname extends StatelessWidget {
  const _Appname({
    Key? key,
    required this.ownstyle,
  }) : super(key: key);

  final TextStyle ownstyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: ownstyle,
        ),
        Text(
          'PLAYER',
          style: ownstyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  VoidCallback ontap;
  _Logo({
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Image.asset('assets/img/logo.png'),
    );
  }
}
