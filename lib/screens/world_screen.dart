import 'package:flutter/material.dart';

class WorldScreen extends StatelessWidget {
  const WorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your impact')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.public, size: 96, color: Colors.green),
              SizedBox(height: 20),
              Text('Your sustainable choices help keep the world clean.'),
            ],
          ),
        ),
      ),
    );
  }
}
