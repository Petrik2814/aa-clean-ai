import 'package:flutter/material.dart';
import 'package:aaclean_ai/services/waste_database_service.dart';
import 'package:aaclean_ai/theme/app_theme.dart';
import 'package:aaclean_ai/widgets/cleany_message_card.dart';

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
  bool _showCorrectionOptions = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search([String? overrideQuery]) async {
    final query = (overrideQuery ?? _controller.text).trim();
    if (query.isEmpty) return;
    setState(() {
      _loading = true;
      _result = null;
      _message = null;
      _showCorrectionOptions = false;
    });

    final item = await _db.find(query);
    if (!mounted) return;

    setState(() {
      _loading = false;
      if (item == null) {
        _result = null;
        _message = 'Tento predmet ešte nemám v databáze. Skús ho opísať inak alebo ho neskôr odfoť.';
      } else {
        _result = item;
        _message = null;
      }
    });
  }

  Color _parseColor(String? hex, Color fallback) {
    if (hex == null || hex.isEmpty) return fallback;
    try {
      final cleaned = hex.replaceAll('#', '');
      final value = int.parse(cleaned, radix: 16);
      if (cleaned.length == 6) {
        return Color(0xFF000000 | value);
      } else if (cleaned.length == 8) {
        return Color(value);
      }
    } catch (_) {}
    return fallback;
  }

  void _onCorrectionChosen(String option) {
    if (_result == null) return;
    if (option == 'Napísať vlastnú odpoveď') {
      final ctrl = TextEditingController();
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Napísať vlastnú odpoveď'),
          content: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'Napr. zmesový odpad')),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Zrušiť')),
            ElevatedButton(
              onPressed: () {
                final custom = ctrl.text.trim();
                if (custom.isNotEmpty) {
                  setState(() {
                    _result!['container'] = custom;
                    _showCorrectionOptions = false;
                    _message = 'Ďakujem, upravil(a) si výsledok.';
                  });
                }
                Navigator.of(ctx).pop();
              },
              child: const Text('Odoslať'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _result!['container'] = option;
        _showCorrectionOptions = false;
        _message = 'Ďakujem, upravil(a) si výsledok.';
      });
    }
  }

  Widget _buildResultView() {
    if (_result == null) {
      return CleanyMessageCard(
        message: _message ?? 'Napíš, čo chceš vyhľadať.',
        subtitle: null,
        accentColor: AppTheme.primary,
      );
    }

    final name = _result!['name'] ?? _result!['itemName'] ?? '';
    final material = _result!['material'] ?? '';
    final container = _result!['container'] ?? '';
    final explanation = _result!['explanation'] ?? '';
    final preparation = _result!['preparation'] ?? '';
    final commonMistake = _result!['commonMistake'] ?? '';
    final containerColorHex = _result!['containerColor'] as String?;
    final accent = _parseColor(containerColorHex, AppTheme.primary);

    final cleanyMsg = 'Našiel som to. Toto patrí do $container.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CleanyMessageCard(message: cleanyMsg, subtitle: '$name', accentColor: accent),
        const SizedBox(height: 12),
        Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          Chip(label: Text(material)),
          Chip(label: Text(container)),
        ]),
        const SizedBox(height: 12),
        if (explanation.isNotEmpty) Text('Vysvetlenie: $explanation'),
        if (preparation.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Príprava: $preparation'),
        ],
        if (commonMistake.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Častá chyba: $commonMistake', style: const TextStyle(color: Colors.black54)),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _showCorrectionOptions = !_showCorrectionOptions),
                child: const Text('Nie je to správne?'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // keep camera flow unchanged: go back to home/start
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Naskenovať znova'),
              ),
            ),
          ],
        ),
        if (_showCorrectionOptions) ...[
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: [
            ElevatedButton(onPressed: () => _onCorrectionChosen('papier (modrý kontajner)'), child: const Text('Iný predmet')),
            ElevatedButton(onPressed: () => _onCorrectionChosen('zmesový odpad'), child: const Text('Iný stav odpadu')),
            OutlinedButton(onPressed: () => _onCorrectionChosen('Napísať vlastnú odpoveď'), child: const Text('Napísať vlastnú odpoveď')),
          ]),
        ],
      ],
    );
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
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: ElevatedButton(onPressed: _search, child: const Text('Hľadaj'))),
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Vyčisti',
                onPressed: () {
                  _controller.clear();
                  setState(() {
                    _result = null;
                    _message = null;
                    _showCorrectionOptions = false;
                  });
                },
                icon: Icon(Icons.clear, color: primary),
              ),
            ]),
            const SizedBox(height: 12),
            // quick test buttons
            Wrap(spacing: 8, children: [
              ElevatedButton(
                onPressed: () => _search('mastná krabica od pizze'),
                child: const Text('Mastná krabica od pizze'),
              ),
              ElevatedButton(
                onPressed: () => _search('zubná kefka'),
                child: const Text('Zubná kefka'),
              ),
              ElevatedButton(
                onPressed: () => _search('PET fľaša'),
                child: const Text('PET fľaša'),
              ),
              ElevatedButton(
                onPressed: () => _search('papierová vreckovka'),
                child: const Text('Papierová vreckovka'),
              ),
            ]),
            const SizedBox(height: 16),
            if (_loading) const CircularProgressIndicator(),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: _buildResultView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
