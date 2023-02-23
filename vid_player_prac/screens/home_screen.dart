import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; //영상 위치, 정보를 저장해야함

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: video == null ? renderEmpty() : renderVideo());
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  Widget renderEmpty() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A3A7C), Color(0xFF000118)]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onLogoTap: onNewVideoPressed,
          ),
          const SizedBox(
            height: 30,
          ),
          AppName(vidstyle: vidstyle),
        ],
      ),
    );
  }

  final TextStyle vidstyle = const TextStyle(
    color: Colors.white,
    fontSize: 30,
  );

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }
}

class AppName extends StatelessWidget {
  const AppName({
    Key? key,
    required this.vidstyle,
  }) : super(key: key);

  final TextStyle vidstyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('VIDEO', style: vidstyle),
        Text(
          'PLAYER',
          style: vidstyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  VoidCallback? onLogoTap;
  _Logo({
    required this.onLogoTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLogoTap,
      child: Image.asset('assets/img/logo.png'),
    );
  }
}
