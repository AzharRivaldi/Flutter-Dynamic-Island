import 'package:flutter/material.dart';

void main() {
  runApp(const DynamicIsland());
}

class DynamicIsland extends StatefulWidget {
  const DynamicIsland({Key? key}) : super(key: key);

  @override
  State<DynamicIsland> createState() => _DynamicIslandState();
}

class _DynamicIslandState extends State<DynamicIsland>
    with TickerProviderStateMixin {
  late final AnimationController callRecController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);
  late final Animation<double> _animation =
      CurvedAnimation(parent: callRecController, curve: Curves.fastOutSlowIn);
  late final AnimationController userController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);
  late final Animation<double> _userAnimation =
      CurvedAnimation(parent: userController, curve: Curves.fastOutSlowIn);

  bool isRecAnimating = false;
  bool isUserAnimating = false;
  bool showBaseTile = true;

  void playRecording() {
    setState(() {
      showBaseTile = !showBaseTile;
      isRecAnimating = !isRecAnimating;
      if (isRecAnimating) {
        callRecController.reset();
      } else {
        callRecController.forward();
      }
    });
  }

  void playUserTile() {
    setState(() {
      showBaseTile = !showBaseTile;
      isUserAnimating = !isUserAnimating;
      if (isUserAnimating) {
        userController.forward();
      } else {
        userController.reset();
      }
    });
  }

  void clearCall() {
    setState(() {
      showBaseTile = true;
      isRecAnimating = false;
      isUserAnimating = false;
      callRecController.reset();
      userController.reset();
    });
  }

  @override
  void dispose() {
    callRecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _callRecordingChip() {
      return SizeTransition(
          sizeFactor: _animation,
          axis: Axis.horizontal,
          child: GestureDetector(
            onTap: () {
              playUserTile();
            },
            child: Container(
              width: 200,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.call, color: Colors.green),
                  const SizedBox(width: 10),
                  const Text("2:56",
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  const Spacer(),
                  Image.asset("assets/images/equalizer.png"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ));
    }

    _notificationChip() {
      return SizeTransition(
          sizeFactor: _userAnimation,
          axis: Axis.vertical,
          axisAlignment: -1,
          child: GestureDetector(
            onTap: () {
              clearCall();
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              width: 400,
              height: 90,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: Offset(0, 2),
                )
              ], borderRadius: BorderRadius.circular(50), color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/kagura.jpg",
                        width: 55,
                        height: 55,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Jasa Aplikasi",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        Text("Azhar Rivaldi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.call_end, color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.call, color: Colors.white)),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ));
    }

    _baseChip() {
      return AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: 1,
        child: GestureDetector(
          onTap: () {
            playRecording();
          },
          child: Container(
            width: 150,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.black),
          ),
        ),
      );
    }

    _mainStack() {
      return Stack(
        alignment: Alignment.center,
        children: [
          _baseChip(),
          _callRecordingChip(),
          _notificationChip(),
        ],
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _mainStack(),
              const SizedBox(height: 200),
              const Text(
                "Flutter\nDynamic Island",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
