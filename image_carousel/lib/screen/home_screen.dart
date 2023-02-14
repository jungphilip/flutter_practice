// 무한 스크롤 버전
import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List imageNum = [1, 2, 3, 4, 5];
  Timer? timer;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(seconds: 1), // 페이지 체류 시간
      ((timer) {
        int currentPage = pageController.page!.toInt();
        int nextPage = currentPage + 1;

        pageController.animateToPage(
            duration: const Duration(seconds: 1), //에니메이션 효과 시간
            curve: Curves.linearToEaseOut,
            nextPage);
      }),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        itemBuilder: ((context, index) {
          int pageShow = index % 5 + 1;
          return Image.asset(
            'asset/img/image_$pageShow.jpeg',
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }
}
