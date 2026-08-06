import 'dart:io';

import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  final String? imagePath;

  const PreviewScreen({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Náhľad fotografie'),
      ),
      body: SafeArea(
        child: hasImage
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(File(imagePath!), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pushReplacementNamed('/camera'),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('Odfotiť znova'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Placeholder for analyze action
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Analyzovanie... (placeholder)')),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('Analyzovať'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Žiadna fotografia na zobrazenie.'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed('/camera'),
                      child: const Text('Odfotiť'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
