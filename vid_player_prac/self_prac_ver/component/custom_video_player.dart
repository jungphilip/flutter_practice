import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player_prac/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final GestureTapCallback onCamera;

  const CustomVideoPlayer({
    super.key,
    required this.video,
    required this.onCamera,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? controller;
  bool show = true;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  void initializeController() async {
    final controller = VideoPlayerController.file(
      File(
        widget.video.path,
      ),
    );

    await controller.initialize();

    controller.addListener(controllerListener); //컨트롤러의 속성이 변경될 때마다 실행할 함수

    setState(() {
      this.controller = controller;
    });
  }

  void controllerListener() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    // TODO: implement didUpdateWidget
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.removeListener(controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: onScreenTap,
      child: AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: videoscreen(
          onPlayLeft: onPlayLeft,
          onPlay: onPlay,
          onPlayRight: onPlayRight,
          controller: controller!,
          showScreen: show,
          onCamera: widget.onCamera,
        ),
      ),
    );
  }

  void onScreenTap() {
    setState(() {
      show = !show;
    });
  }

  void onPlayLeft() {
    final currentPosition = controller!.value.position;
    Duration position = const Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }

    controller!.seekTo(position);
  }

  void onPlay() {
    if (controller!.value.isPlaying) {
      controller!.pause();
    } else {
      controller!.play();
    }
  }

  void onPlayRight() {
    final currentPosition = controller!.value.position;
    final max = controller!.value.duration;
    Duration position = const Duration();

    if ((max - currentPosition).inSeconds > 3) {
      position = currentPosition + const Duration(seconds: 3);
    } else {
      position = max;
    }

    controller!.seekTo(position);
  }
}

class videoscreen extends StatelessWidget {
  final GestureTapCallback onPlayLeft;
  final GestureTapCallback onPlay;
  final GestureTapCallback onPlayRight;
  final GestureTapCallback onCamera;
  final VideoPlayerController controller;
  final bool showScreen;
  const videoscreen(
      {required this.onPlayLeft,
      required this.onPlay,
      required this.onPlayRight,
      required this.controller,
      required this.showScreen,
      required this.onCamera,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayer(controller),
        if (showScreen)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
        if (showScreen)
          Align(
            alignment: Alignment.center,
            child: Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    onPressed: onPlayLeft,
                    icondata: Icons.rotate_left_rounded,
                  ),
                  CustomIconButton(
                    onPressed: onPlay,
                    icondata: controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  CustomIconButton(
                    onPressed: onPlayRight,
                    icondata: Icons.rotate_right_outlined,
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Text(
                  '${controller.value.position.inMinutes.toString().padLeft(2, '0')}:${(controller.value.position.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: controller.value.position.inSeconds
                        .toDouble(), // 동영상 재생 위치를 나타냄
                    min: 0,
                    max: controller.value.duration.inSeconds.toDouble(),
                    onChanged: (double val) {
                      controller.seekTo(
                        Duration(
                          seconds: val.toInt(),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  '${controller.value.duration.inMinutes.toString().padLeft(2, '0')}:${(controller.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: CustomIconButton(
            onPressed: onCamera,
            icondata: Icons.photo_camera_back,
          ),
        ),
      ],
    );
  }
}
