import 'package:flutter/material.dart';

import '../models/waste_item.dart';
import '../services/ai_service.dart';
import '../widgets/primary_button.dart';
import '../widgets/waste_card.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final AiService _aiService = AiService();
  WasteItem? _result;
  bool _isScanning = false;

  Future<void> _scan() async {
    setState(() => _isScanning = true);
    final result = await _aiService.identifyWaste();
    if (!mounted) return;
    setState(() {
      _result = result;
      _isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan waste')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _result == null
                    ? const Icon(Icons.document_scanner_outlined, size: 120)
                    : WasteCard(item: _result!),
              ),
            ),
            PrimaryButton(
              label: _isScanning ? 'Identifying…' : 'Take a photo',
              icon: Icons.camera_alt_outlined,
              onPressed: _isScanning ? null : _scan,
            ),
          ],
        ),
      ),
    );
  }
}
