import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class WasteDatabaseService {
  List<Map<String, dynamic>> _items = [];

  Future<void> load() async {
    if (_items.isNotEmpty) return;
    final raw = await rootBundle.loadString('assets/data/waste_items_sk.json');
    final List<dynamic> parsed = json.decode(raw) as List<dynamic>;
    _items = parsed.cast<Map<String, dynamic>>();
  }

  // Normalize by removing diacritics and lowering case
  String _normalize(String input) {
    final s = input.toLowerCase();
    const Map<String, String> map = {
      'á':'a','ä':'a','č':'c','ď':'d','é':'e','ě':'e','í':'i','ľ':'l','ĺ':'l',
      'ň':'n','ó':'o','ô':'o','ŕ':'r','š':'s','ť':'t','ú':'u','ů':'u','ý':'y','ž':'z',
      'Á':'A','Ä':'A','Č':'C','Ď':'D','É':'E','Ě':'E','Í':'I','Ľ':'L','Ĺ':'L',
      'Ň':'N','Ó':'O','Ô':'O','Ŕ':'R','Š':'S','Ť':'T','Ú':'U','Ů':'U','Ý':'Y','Ž':'Z'
    };
    var out = s;
    map.forEach((k, v) {
      out = out.replaceAll(k, v);
    });
    return out;
  }

  Future<Map<String, dynamic>?> find(String query) async {
    await load();
    final q = _normalize(query);
    Map<String, dynamic>? best;
    int bestScore = -1;

    for (final item in _items) {
      final name = _normalize(item['name'] as String? ?? '');
      int score = 0;
      if (name == q) score += 100;
      else if (name.contains(q)) score += 50;

      final aliases = (item['aliases'] as List<dynamic>?)
              ?.map((e) => _normalize(e as String))
              .toList() ??
          [];
      for (final a in aliases) {
        if (a == q) score += 90;
        else if (a.contains(q)) score += 40;
      }

      if (score > bestScore) {
        bestScore = score;
        best = Map<String, dynamic>.from(item);
      }
    }

    if (bestScore <= 0) return null;
    return best;
  }
}
