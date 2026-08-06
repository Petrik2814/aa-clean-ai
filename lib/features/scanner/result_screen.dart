import 'package:flutter/material.dart';
import 'package:aaclean_ai/theme/app_theme.dart';
import 'package:aaclean_ai/models/waste_analysis_result.dart';

class WasteResultScreen extends StatelessWidget {
  final Map<String, dynamic>? result;
  const WasteResultScreen({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Výsledok analýzy')),
        body: const Center(child: Text('Žiadny výsledok analýzy.')),
      );
    }

    final analysis = WasteAnalysisResult.fromJson(result!);
    final primary = AppTheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Výsledok analýzy')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                analysis.itemName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primary),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Chip(label: Text(analysis.material)),
                  const SizedBox(width: 8),
                  Chip(label: Text(analysis.container)),
                  const SizedBox(width: 8),
                  Chip(label: Text('${(analysis.confidence * 100).toStringAsFixed(0)}%')),
                ],
              ),
              const SizedBox(height: 16),
              Text('Vysvetlenie', style: TextStyle(fontWeight: FontWeight.bold, color: primary)),
              const SizedBox(height: 8),
              Text(analysis.explanation),
              const SizedBox(height: 20),
              if (analysis.needsClarification) ...[
                Text('Potrebné upresnenie', style: TextStyle(fontWeight: FontWeight.bold, color: primary)),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(analysis.clarificationQuestion ?? ''),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder: handle user's clarification answer
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Odoslané: Áno')));
                      },
                      child: const Text('Áno'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Odoslané: Nie')));
                      },
                      child: const Text('Nie'),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Späť na domov'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
