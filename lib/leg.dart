import 'package:flutter/material.dart';

class LegPage extends StatelessWidget {
  const LegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leg Exercises")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ExerciseTile(title: "Single-leg Squats"),
          ExerciseTile(title: "Bridge with Ball"),
          ExerciseTile(title: "Single-leg Bridge"),
          ExerciseTile(title: "Double Knee to Chest"),
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
