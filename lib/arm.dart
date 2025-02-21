import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class ArmPage extends StatelessWidget {
  const ArmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arm Exercises')),
      body: ListView(
        children: const [
          ExerciseDetail(
            title: "Arm Swings",
            description: "Arm swings help stretch and warm up your shoulders.",
            duration: "Duration: 3 minutes",
            image: "assets/arm_swing.webp",
          ),
          ExerciseDetail(
            title: "Arm Rotations",
            description: "Arm rotations improve shoulder flexibility.",
            duration: "Duration: 2 minutes",
            image: "assets/arm_swing.webp",
          ),
          ExerciseDetail(
            title: "Wrist Bends",
            description: "Wrist bends stretch and strengthen your wrist muscles.",
            duration: "Duration: 2 minutes",
            image: "assets/arm_swing.webp",
          ),
          ExerciseDetail(
            title: "Shoulder Stretches",
            description: "Shoulder stretches help relax and stretch the shoulder muscles.",
            duration: "Duration: 3 minutes",
            image: "assets/arm_swing.webp",
          ),
        ],
      ),
    );
  }
}

class ExerciseDetail extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String image;

  const ExerciseDetail({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(description),
            const SizedBox(height: 10),
            Text(duration),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseTimerPage(
                        title: title,
                        duration: duration,
                      ),
                    ),
                  );
                },
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseTimerPage extends StatefulWidget {
  final String title;
  final String duration;

  const ExerciseTimerPage({super.key, required this.title, required this.duration});

  @override
  _ExerciseTimerPageState createState() => _ExerciseTimerPageState();
}

class _ExerciseTimerPageState extends State<ExerciseTimerPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraActive = false;
  bool _isTimerActive = false;
  late Timer _timer;
  int _remainingTime = 0;

  @override
  void initState() {
    super.initState();
  }

  void _startCameraAndTimer() async {
    // Start the timer based on the duration
    setState(() {
      _isCameraActive = true;
      _isTimerActive = true;
      _remainingTime = int.parse(widget.duration.split(' ')[1]) * 60; // Convert minutes to seconds
    });

    // Get the available cameras
    final cameras = await availableCameras();

    // Find the front camera
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first, // Default to first camera if no front camera is found
    );

    // Initialize the camera controller with the front camera
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();

    // Start the countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          // Camera Feed
          Expanded(
            child: _isCameraActive
                ? FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        bool isFrontCamera = _controller.description.lensDirection == CameraLensDirection.front;
                        return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationZ(1.5708*3), // Rotate 90 degrees (π/2 in radians)
                                child: CameraPreview(_controller),
                              );

                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : const Center(child: Text('Camera not started yet')),
          ),

          // Timer and Start Button
          Container(
            color: Colors.blue[50],
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isTimerActive
                      ? 'Time Left: ${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}'
                      : widget.duration,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _isTimerActive ? null : _startCameraAndTimer,
                  child: Text(_isTimerActive ? 'Running...' : 'Start Camera and Timer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
