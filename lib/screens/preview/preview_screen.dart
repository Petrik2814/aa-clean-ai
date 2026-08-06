import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                            onPressed: () async {
                              final newPath = await context.push<String>('/camera');
                              if (!context.mounted || newPath == null) return;
                              context.go('/preview', extra: newPath);
                            },
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
                              // Spusti loading/analyzovanie
                              context.push('/analysis', extra: imagePath);
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
                      onPressed: () async {
                        final newPath = await context.push<String>('/camera');
                        if (!context.mounted || newPath == null) return;
                        context.go('/preview', extra: newPath);
                      },
                      child: const Text('Odfotiť'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
