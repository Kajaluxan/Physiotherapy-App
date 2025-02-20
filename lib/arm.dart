import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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

  Future<void> _openCamera(BuildContext context) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(camera: firstCamera),
      ),
    );
  }

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
                onPressed: () => _openCamera(context), // Open camera
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Picture saved at ${image.path}')),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
