import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;

  static const LatLng homeLatLng = LatLng(
    37.2418262,
    127.1190211,
  );

  static const CameraPosition initialPosition = CameraPosition(
    target: homeLatLng,
    zoom: 17,
  );

  static const double distance = 100;
  static final Circle withinDistanceCircle = Circle(
    circleId: const CircleId(
        'withinDistanceCircle'), //여러개의 동그라미를 그렸을 때 같은 동그라미인지 아닌지 구분해주는 식별자 역할
    center: homeLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: distance,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  static final Circle notWithinDistanceCircle = Circle(
    circleId: const CircleId(
        'notWithinDistanceCircle'), //여러개의 동그라미를 그렸을 때 같은 동그라미인지 아닌지 구분해주는 식별자 역할
    center: homeLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    radius: distance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  static final Circle checkDoneCircle = Circle(
    circleId: const CircleId(
        'checkDoneCircle'), //여러개의 동그라미를 그렸을 때 같은 동그라미인지 아닌지 구분해주는 식별자 역할
    center: homeLatLng,
    fillColor: Colors.green.withOpacity(0.5),
    radius: distance,
    strokeColor: Colors.green,
    strokeWidth: 1,
  );

  static const Marker marker = Marker(
    markerId: MarkerId('home'),
    position: LatLng(37.2418262, 127.1190211),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder(
        future:
            checkPermission(), //Future를 리턴해주는 어떤 함수든 넣어줄 수 있음, 함수의 상태가 변경될 때 마다 builder를 다시 실행하여 화면을 다시 그릴 수 있음
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == '위치 권한이 허가되었습니다.') {
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false;

                  if (snapshot.hasData) {
                    final start = snapshot.data!;
                    const end = homeLatLng;
                    final between = Geolocator.distanceBetween(
                      start.latitude,
                      start.longitude,
                      end.latitude,
                      end.longitude,
                    );

                    if (between < distance) {
                      isWithinRange = true;
                    }
                  }
                  return Column(
                    children: [
                      _CustomGoolgeMap(
                        initialPosition: initialPosition,
                        circle: choolCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : notWithinDistanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      _CheckButton(
                        isWithinRange: isWithinRange,
                        choolCheckDone: choolCheckDone,
                        onPressed: onChoolcheckPressed,
                      ),
                    ],
                  );
                });
          }

          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  onChoolcheckPressed() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('귀가하기'),
          content: const Text('귀가를 하시겠습니까?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('취소')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('귀가하기')),
          ],
        );
      },
    );
    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }

  // 권한과 관련된 작업은 모두 async로 하게 되어있음
  // user input을 기다리기 때문
  checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    return '위치 권한이 허가되었습니다.';
  }

  AppBar renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        '오늘도 귀가',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            if (mapController == null) {
              return;
            }

            final location1 = await Geolocator.getCurrentPosition();

            mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(
                  location1.latitude,
                  location1.longitude,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.my_location,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class _CheckButton extends StatelessWidget {
  _CheckButton({
    required this.choolCheckDone,
    required this.onPressed,
    required this.isWithinRange,
  });

  bool isWithinRange;
  VoidCallback onPressed;
  bool choolCheckDone;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50,
            color: choolCheckDone
                ? Colors.green
                : isWithinRange
                    ? Colors.blue
                    : Colors.red,
          ),
          const SizedBox(height: 20),
          if (isWithinRange && !choolCheckDone)
            TextButton(
              onPressed: onPressed,
              child: const Text('귀가완료'),
            )
        ],
      ),
    );
  }
}

class _CustomGoolgeMap extends StatelessWidget {
  const _CustomGoolgeMap({
    Key? key,
    required this.initialPosition,
    required this.circle,
    required this.marker,
    required this.onMapCreated,
  }) : super(key: key);

  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal, //MapType은 enum형식
        initialCameraPosition: initialPosition,
        myLocationButtonEnabled: false,
        circles: {circle},
        markers: {marker},
        onMapCreated: onMapCreated,
      ),
    );
  }
}
