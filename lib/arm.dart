import 'package:flutter/material.dart';

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
            image: "assets/arm_swing.webp", // Replace with actual image path
          ),
          ExerciseDetail(
            title: "Arm Rotations",
            description: "Arm rotations improve shoulder flexibility.",
            duration: "Duration: 2 minutes",
            image: "assets/arm_swing.webp", // Replace with actual image path
          ),
          ExerciseDetail(
            title: "Wrist Bends",
            description: "Wrist bends stretch and strengthen your wrist muscles.",
            duration: "Duration: 2 minutes",
            image: "assets/arm_swing.webp", // Replace with actual image path
          ),
          ExerciseDetail(
            title: "Shoulder Stretches",
            description: "Shoulder stretches help relax and stretch the shoulder muscles.",
            duration: "Duration: 3 minutes",
            image: "assets/arm_swing.webp", // Replace with actual image path
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
            Image.asset(image), // Display exercise image
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
                  // Add your start button functionality here
                  // For example, you could navigate to a timer screen or start the exercise
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