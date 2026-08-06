import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class WasteResultScreen extends StatelessWidget {
  const WasteResultScreen({super.key, this.result});

  final Map<String, dynamic>? result;

  @override
  Widget build(BuildContext context) {
    final data = result ??
        const <String, dynamic>{
          'name': 'Papierová vreckovka',
          'material': 'Znečistený papier',
          'container': 'Zmesový odpad',
          'warning': 'Použitá vreckovka nepatrí do papiera.',
          'confidence': '95 %',
          'explanation':
              'Použitá papierová vreckovka je znečistená a jej vlákna už nie sú vhodné na recykláciu.',
        };

    return Scaffold(
      appBar: AppBar(title: const Text('Výsledok analýzy')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(Icons.recycling, size: 72, color: AppTheme.green),
            const SizedBox(height: 16),
            Text(
              data['name']?.toString() ?? 'Neznámy odpad',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _InfoTile(label: 'Materiál', value: data['material']?.toString() ?? '—'),
            _InfoTile(label: 'Kam patrí', value: data['container']?.toString() ?? '—'),
            _InfoTile(label: 'Istota', value: data['confidence']?.toString() ?? '—'),
            if ((data['warning']?.toString() ?? '').isNotEmpty)
              Card(
                color: AppTheme.yellow.withValues(alpha: 0.18),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.warning_amber_rounded),
                      const SizedBox(width: 12),
                      Expanded(child: Text(data['warning'].toString())),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Prečo?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(data['explanation']?.toString() ?? 'Bez vysvetlenia.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => context.go('/camera'),
              icon: const Icon(Icons.camera_alt),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('Naskenovať znova'),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text('Späť domov'),
            ),
            const SizedBox(height: 20),
            const Text('Bola odpoveď užitočná?', textAlign: TextAlign.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_down_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
