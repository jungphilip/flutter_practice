import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video,
    super.key,
    required this.onNewVideoPressed,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = const Duration();
  bool showControls = false;

  @override
  void initState() {
    super.initState();

    initializeController();
  }

  initializeController() async {
    currentPosition = const Duration();
    videoController = VideoPlayerController.file(File(widget.video.path));

    await videoController!.initialize();

    videoController!.addListener(() {
      final currentPosition = videoController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
    });
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initializeController(); //만약 이전 위젯의 비디오의 경로가 새로 불러온 비디오의 경로가 다르다면 controller를 다시 initialize
    }
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return const CircularProgressIndicator();
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            if (showControls)
              _Controls(
                onForwardPressed: onForwardPressed,
                onPlayPressed: onPlayPressed,
                onReversePressed: onReversePressed,
                isPlaying: videoController!.value.isPlaying,
              ),
            if (showControls)
              _NewVideo(
                onPressed: widget.onNewVideoPressed,
              ),
            _SliderBottom(
                currentPosition: currentPosition,
                videoController: videoController),
          ],
        ),
      ),
    );
  }

  void onForwardPressed() {
    final currentPosition = videoController!.value.position;

    Duration position = videoController!.value.duration;

    if (position.inSeconds - currentPosition.inSeconds > 3) {
      position = currentPosition + const Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    // 이미 실행중이면 중지
    // 실행중이 아니면 실행

    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;

    Duration position = const Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }
}

class _SliderBottom extends StatelessWidget {
  const _SliderBottom({
    Key? key,
    required this.currentPosition,
    required this.videoController,
  }) : super(key: key);

  final Duration currentPosition;
  final VideoPlayerController? videoController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: [
            Text(
              '${currentPosition.inMinutes.toString().padLeft(2, '0')} : ${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                max: videoController!.value.duration.inSeconds.toDouble(),
                min: 0,
                value: currentPosition.inSeconds.toDouble(),
                onChanged: (double val) {
                  videoController!.seekTo(Duration(seconds: val.toInt()));
                },
              ),
            ),
            Text(
              '${videoController!.value.duration.inMinutes.toString().padLeft(2, '0')} : ${videoController!.value.duration.inSeconds % 60}',
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;
  const _NewVideo({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        color: Colors.white,
        iconSize: 30,
        onPressed: onPressed,
        icon: const Icon(Icons.photo_camera_back),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls({
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.onForwardPressed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
            onPressed: onReversePressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onForwardPressed,
            iconData: Icons.rotate_right,
          ),
        ],
      ),
    );
  }

  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30,
      color: Colors.white,
      icon: Icon(
        iconData,
      ),
    );
  }
}
