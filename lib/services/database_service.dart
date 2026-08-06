import '../models/waste_item.dart';

class DatabaseService {
  final List<WasteItem> _history = [];

  Future<List<WasteItem>> getHistory() async => List.unmodifiable(_history);

  Future<void> save(WasteItem item) async => _history.add(item);
}
