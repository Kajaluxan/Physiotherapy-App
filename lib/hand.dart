import 'package:flutter/material.dart';

class HandPage extends StatelessWidget {
  const HandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hand Exercises")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ExerciseTile(title: "Finger Stretch"),
          ExerciseTile(title: "Thumb Stretch"),
          ExerciseTile(title: "Finger Lift"),
          ExerciseTile(title: "Thumb Extension"),
          ExerciseTile(title: "Wrist Stretch"),
          ExerciseTile(title: "Claw Stretch"),
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
