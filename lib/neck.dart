import 'package:flutter/material.dart';

class NeckPage extends StatelessWidget {
  const NeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neck Exercises")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ExerciseTile(title: "Neck Rotations"),
          ExerciseTile(title: "Neck Tilts"),
          ExerciseTile(title: "Neck Stretches"),
          ExerciseTile(title: "Shoulder Blade Pinches"),
        ],
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String title;

  const ExerciseTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: const Icon(Icons.fitness_center, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
