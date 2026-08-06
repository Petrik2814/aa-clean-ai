import 'package:flutter/material.dart';
import 'package:aaclean_ai/services/waste_database_service.dart';
import 'package:aaclean_ai/theme/app_theme.dart';

class WasteSearchScreen extends StatefulWidget {
  const WasteSearchScreen({super.key});

  @override
  State<WasteSearchScreen> createState() => _WasteSearchScreenState();
}

class _WasteSearchScreenState extends State<WasteSearchScreen> {
  final _controller = TextEditingController();
  final _db = WasteDatabaseService();
  Map<String, dynamic>? _result;
  String? _message;
  bool _loading = false;

  Future<void> _search() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return;
    setState(() {
      _loading = true;
      _result = null;
      _message = null;
    });
    final item = await _db.find(q);
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (item == null) {
        _message = 'Predmet zatiaľ nie je v databáze. Neskôr ho skontroluje AI.';
      } else {
        _result = item;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppTheme.primary;
    return Scaffold(
      appBar: AppBar(title: const Text('Vyhľadaj odpad')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Zadaj názov (napr. mastná krabica od pizze)',
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _search, child: const Text('Hľadaj')),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_message != null) Text(_message!),
            if (_result != null) ...[
              Text(
                _result!['name'] as String,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primary),
              ),
              const SizedBox(height: 8),
              Text('Kontajner: ${_result!['container']}'),
              const SizedBox(height: 8),
              Text('Vysvetlenie: ${_result!['explanation']}'),
            ],
          ],
        ),
      ),
    );
  }
}
